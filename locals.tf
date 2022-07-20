locals {
  bucket_name  = "g10-itba-cloud-computing"
  iam_role_arn = "arn:aws:iam::841937269256:role/LabRole" #LabRole ARN

  sg_id = "sg-005d25b37b7336630" #VPC Security Group ID

  password_secret_manager = "aurora-password-secret"
}
