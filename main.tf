module "s3" {
  for_each = local.s3
  source   = "./module/s3"

  providers = {
    aws = aws.aws
  }

  bucket_name = each.value.bucket_name
  objects     = try(each.value.objects, {})
  policy      = each.value.policy
}

# resource "aws_s3_object" "this" {
#   provider = aws.aws

#   bucket        = module.s3["website"].id
#   key           = "index.html"
#   content       = data.template_file.userdata.rendered
#   content_type  = "text/html"
#   storage_class = "STANDARD"
# }


# Define reports bucket lifecycle transitions
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  provider = aws.aws

  bucket = module.s3["reports"].id

  rule {
    id     = "rule-1"
    status = "Enabled"

    transition {
      days          = "30"
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = "365"
      storage_class = "GLACIER"
    }
  }
}


module "vpc" {
  source = "./module/vpc"

  providers = {
    aws = aws.aws
  }

  vpc_cidr = local.vpc.vpc_cidr
  availability_zones   = local.vpc.availability_zones
}

module "iam" {
  source = "./module/iam"

  providers = {
    aws = aws.aws
  }
}

module "lambda" {
  source = "./module/lambda"

  providers = {
    aws = aws.aws
  }

  functions = {for k, v in local.lambda_function.functions: k => merge(v, { 
    iam_role = module.iam.arn
    # execution_arn = module.api_gw.arn 
    subnet_ids = module.vpc.private_subnet_ids
    security_group_ids = []
  })}
}


module "api_gw" {
  source = "./module/api_gw"

  providers = {
    aws = aws.aws
  }

  name      = local.api_gw.name
  endpoints = toset([for e in local.api_gw.endpoints: e.path])
  methods = {
    for e in local.api_gw.endpoints : "${e.method} ${e.path}" => merge(e, {
      lambda = {
        name = module.lambda.functions[e.lambda_name].name
        arn = module.lambda.functions[e.lambda_name].arn
      }
    })
  }
}



module "cloudfront" {
  source = "./module/cloudfront"

  providers = {
    aws = aws.aws
  }

  bucket_name = local.cloud_front.bucket_name
  logging_bucket_name = local.cloud_front.logging_bucket_name
  api_gw_url = module.api_gw.url
}



# module "aurora" {
#   source = "./module/aurora"
  
# }