data "aws_secretsmanager_secret" "password" {
  name = var.password_secret_manager
}

data "aws_secretsmanager_secret_version" "password" {
  secret_id = data.aws_secretsmanager_secret.password.id
}
 