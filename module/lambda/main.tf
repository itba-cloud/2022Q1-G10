resource "aws_lambda_function" "this" {
  filename      = var.zip
  function_name = var.name
  role          = var.iam_role
  handler       = var.handler
  runtime       = var.runtime

  vpc_config {
    subnet_ids = var.subnet_ids
    security_group_ids = var.security_group_ids
  }
}

