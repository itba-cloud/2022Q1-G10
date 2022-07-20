

module "vpc" {
  source = "./module/vpc"

  providers = {
    aws = aws.aws
  }

  vpc_cidr = "10.0.0.0/16"
  availability_zones = [{
    az                   = "us-east-1a"
    private_subnet_cidrs = ["10.0.0.0/24", "10.0.1.0/24"]
    public_subnet_cidrs  = []
    }, {
    az                   = "us-east-1b"
    private_subnet_cidrs = ["10.0.2.0/24", "10.0.3.0/24"]
    public_subnet_cidrs  = []
  }]
}


# Couldn´t create roles. We used LabRole

# module "iam" {
#   source = "./module/iam"

#   providers = {
#     aws = aws.aws
#   }

#   role_name          = "iam_role"
#   policy_name        = "iam_policy"
#   policy_description = "iam_policy_description"
# }

module "lambda" {
  source = "./module/lambda"

  providers = {
    aws = aws.aws
  }

  for_each = local.lambda_functions.functions

  iam_role           = local.iam_role_arn
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [local.sg_id]
  name               = each.value.name
  zip                = each.value.zip
  handler            = each.value.handler
  runtime            = each.value.runtime
}


module "api_gw" {
  source = "./module/api_gw"

  providers = {
    aws = aws.aws
  }

  iam_role  = local.iam_role_arn
  name      = local.api_gw.name
  endpoints = toset([for e in local.api_gw.endpoints : e.path])
  resources = local.api_gw.resources
  methods = {
    for e in local.api_gw.endpoints : "${e.method} ${e.full_path}" => merge(e, {
      lambda = {
        name = module.lambda[e.lambda_name].name
        arn  = module.lambda[e.lambda_name].arn
      }
    })
  }
}

module "s3" {
  for_each = local.s3
  source   = "./module/s3"

  providers = {
    aws = aws.aws
  }

  bucket_name = each.value.bucket_name
  objects     = try(each.value.objects, {})
  policy      = each.value.policy
  is_website  = each.value.is_website
  lambda_arns = [local.iam_role_arn]
}

module "s3_redirect" {
  for_each = local.s3_redirect
  source   = "./module/s3"

  providers = {
    aws = aws.aws
  }

  bucket_name = each.value.bucket_name
  objects     = {}
  policy      = each.value.policy
  is_redirect = true
  redirect    = module.s3[each.value.redirect].website_endpoint
  lambda_arns = []
  depends_on = [
    module.s3
  ]
}

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

# Problems with lab permissions

# module "cloudfront" {
#   source = "./module/cloudfront"

#   providers = {
#     aws = aws.aws
#   }

#   bucket_name         = local.cloud_front.bucket_name
#   logging_bucket_name = local.cloud_front.logging_bucket_name
#   api_gw_url          = module.api_gw.url
#   origin_id           = local.cloud_front.origin_id
# }

resource "random_password" "master" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

// Problems with lab permissions

# resource "aws_secretsmanager_secret" "password" {
#   name = local.password_secret_manager
# }

# resource "aws_secretsmanager_secret_version" "password" {
#   secret_id     = aws_secretsmanager_secret.password.id
#   secret_string = random_password.master.result
# }

module "aurora" {
  source = "./module/aurora"

  providers = {
    aws = aws.aws
  }

  cluster_identifier        = "itba-cloud-computing"
  engine                    = "aurora-postgresql"
  engine_mode               = "provisioned"
  engine_version            = "13.6"
  database_name             = "cloudcomputing"
  master_username           = "postgres"
  password_secret_manager   = local.password_secret_manager
  availability_zones        = ["us-east-1a", "us-east-1b", "us-east-1c"]
  storage_encrypted         = true
  subnet_group_name         = "itba-cloud-computing-db-subnet-group"
  min_capacity              = 0.5
  max_capacity              = 5
  final_snapshot_identifier = "itba-cloud-computing-final-snapshot"

  subnet_ids = module.vpc.private_subnet_ids

  # depends_on = [
  #   aws_secretsmanager_secret.password
  # ]
}
