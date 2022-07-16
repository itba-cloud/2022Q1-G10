locals {
  s3 = {
    # 1 - Website
    website = {
      bucket_name = local.bucket_name
      path        = "./resources"
      is_website = true

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

    # 3 - Website Logs
    logs = {
      is_website = false
      bucket_name = "${local.bucket_name}-logs"

      policy = "public_read"
    }

    reports = {
      bucket_name = "${local.bucket_name}-reports"
      is_website = false
      tier        = "STANDARD"
      policy      = "lambda_only"
    }
  }

  s3_redirect = {
    www-website = {
      is_website = false
      redirect = "website"
      bucket_name = "www.${local.bucket_name}"
      policy      = "public_read"
    }
  }

  cloud_front = {
    bucket_name         = local.s3_redirect.www-website.bucket_name
    logging_bucket_name = local.s3.logs.bucket_name
    origin_id           = "frontend"
  }
}
