locals {
  bucket_name = "b123123123123-itba-cloud-computing"
  path        = "./resources"

  cloud_front = {
    bucket_name         = local.s3.www-website.bucket_name
    logging_bucket_name = local.s3.logs.bucket_name
  }

  s3 = {
    # 1 - Website
    website = {
      bucket_name = local.bucket_name
      path        = "./resources"

      objects = {
        error = {
          filename     = "html/error.html"
          content_type = "text/html"
        }
      }

      policy = {
        version = "2012-10-17"
        statement = {
          effect = "Allow"
          actions = [
            "s3:GetObject",
          ]
          principal = {
            type = "AWS"
            identifiers = ["*"]
          }
        }
      }
    }

    # 2 - WWW Website
    www-website = {
      bucket_name = "www.${local.bucket_name}"
      policy = {
        version = "2012-10-17"
        statement = {
          effect = "Allow"
          actions = [
            "s3:GetObject",
          ]
          principal = {
            type = "AWS"
            identifiers = ["*"]
          }
        }
      }
    }

    # 3 - Website Logs
    logs = {
      bucket_name = "${local.bucket_name}-logs"
      policy = {
        version = "2012-10-17"
        statement = {
          effect = "Allow"
          actions = [
            "s3:GetObject",
          ]
          principal = {
            type = "AWS"
            identifiers = ["*"]
          }
        }
      }
    }

    reports = {
      bucket_name = "${local.bucket_name}-reports"
      tier        = "STANDARD"
      policy = {
        version = "2012-10-17"
        statement = {
          effect = "Deny"
          actions = [
            "s3:GetObject"
          ]
          principal = {
            type = "AWS"
            identifiers = ["*"]
          }
        }
      }
    }
  }

  vpc = {
    vpc_cidr = "10.0.0.0/16"
    # private_subnet_cidrs = ["10.0.0.0/24", "10.0.1.0/24"]
    # availability_zones   = ["us-east-1a", "us-east-1b"]
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

  api_gw = {
    name = "my-api-gw"
    endpoints = {
      get_users = {
        method = "GET"
        path   = "users"
        # lambda = "arn:aws:lambda:us-east-1:123123123123:function:my-api-gw-users" # TODO: Setear bien
        lambda_name = "get-users"
      }

      put_user = {
        method = "PUT"
        path   = "users"
        # lambda = "arn:aws:lambda:us-east-1:123123123123:function:my-api-gw-users" # TODO: Setear bien
        lambda_name = "put-user"
      }


      create_user = {
        method = "POST"
        path   = "users"
        lambda_name = "create-user"
        # lambda = "arn:aws:lambda:us-east-1:123123123123:function:my-api-gw-users" # TODO: Setear bien
      }

      get_report = {
        method = "GET"
        path   = "report"
        lambda_name = "get-report"
        # lambda = "arn:aws:lambda:us-east-1:123123123123:function:my-api-gw-users" # TODO: Setear bien
      }

      get_timesheet = {
        method = "GET"
        path   = "timesheet"
        lambda_name = "get-timesheet"
        # lambda = "arn:aws:lambda:us-east-1:123123123123:function:my-api-gw-users" # TODO: Setear bien
      }

      put_timesheet = {
        method = "PUT"
        path   = "timesheet"
        lambda_name = "put-timesheet"
        # lambda = "arn:aws:lambda:us-east-1:123123123123:function:my-api-gw-users" # TODO: Setear bien
      }

      post_timesheet = {
        method = "POST"
        path   = "timesheet"
        lambda_name = "post-timesheet"
        # lambda = "arn:aws:lambda:us-east-1:123123123123:function:my-api-gw-users" # TODO: Setear bien
      }

    }

  }

  lambda_function = {
    functions = {
      get_users = {
        name    = "get-users"
        zip     = "./resources/lambdas/get_users.zip"
        handler = "get_users.handler"
        runtime = "nodejs16.x"
      }
      put_user = {
        name    = "put-user"
        zip     = "./resources/lambdas/put_user.zip"
        handler = "put_user.handler"
        runtime = "nodejs16.x"
      }
      create_user = {
        name    = "create-user"
        zip     = "./resources/lambdas/create_user.zip"
        handler = "create_user.handler"
        runtime = "nodejs16.x"
      }
      get_report = {
        name    = "get-report"
        zip     = "./resources/lambdas/get_report.zip"
        handler = "get_report.handler"
        runtime = "nodejs16.x"
      }
      get_timesheet = {
        name    = "get-timesheet"
        zip     = "./resources/lambdas/get_timesheet.zip"
        handler = "get_timesheet.handler"
        runtime = "nodejs16.x"
      }
      put_timesheet = {
        name    = "put-timesheet"
        zip     = "./resources/lambdas/put_timesheet.zip"
        handler = "put_timesheet.handler"
        runtime = "nodejs16.x"
      }
      post_timesheet = {
        name    = "post-timesheet"
        zip     = "./resources/lambdas/post_timesheet.zip"
        handler = "post_timesheet.handler"
        runtime = "nodejs16.x"
      }
    }
  }
}

