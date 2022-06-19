resource "aws_lambda_function" "this" {
  for_each = var.functions

  filename      = each.value.zip
  function_name = each.value.name
  role          = each.value.iam_role
  handler       = each.value.handler
  runtime       = each.value.runtime
  # depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]

  vpc_config {
    subnet_ids = each.value.subnet_ids
    security_group_ids = each.value.security_group_ids
  }
}

# resource "aws_lambda_permission" "this" {
#   for_each = var.functions

#   statement_id  = "AllowAPIGatewayInvoke"
#   action        = "lambda:InvokeFunction"
#   function_name = each.value.name
#   principal     = "apigateway.amazonaws.com"

#   # The /*/* portion grants access from any method on any resource
#   # within the API Gateway "REST API".
#   source_arn = "${each.value.execution_arn}/*/*"
# }

