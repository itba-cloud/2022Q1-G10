locals {
  s3 = {
    # 1 - Website
    website = {
      bucket_name = local.bucket_name
      path        = "./resources"

      objects = {
        index = {
          filename     = "html/index.html"
          content_type = "text/html"
        },
        error = {
          filename     = "html/error.html"
          content_type = "text/html"
        }
      }

      policy = "public_read"
    }

    # 2 - WWW Website
    www-website = {
      bucket_name = "www.${local.bucket_name}"
      policy      = "public_read"
    }

    # 3 - Website Logs
    logs = {
      bucket_name = "${local.bucket_name}-logs"

      policy = "public_read"
    }

    reports = {
      bucket_name = "${local.bucket_name}-reports"
      tier        = "STANDARD"
      policy      = "lambda_only"
    }
  }
}
