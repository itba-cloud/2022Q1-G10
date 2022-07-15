locals {
  bucket_name = "b123123123123-itba-cloud-computing"

  cloud_front = {
    bucket_name         = local.s3.www-website.bucket_name
    logging_bucket_name = local.s3.logs.bucket_name
    origin_id           = "frontend"
  }

  password_secret_manager = "aurora-master-password-secret"
}
