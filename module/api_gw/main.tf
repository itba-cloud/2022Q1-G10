resource "aws_api_gateway_rest_api" "this" {
  name = var.name
}

resource "aws_api_gateway_resource" "this" {
  for_each = var.endpoints

  parent_id = aws_api_gateway_rest_api.this.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.this.id
  path_part   = each.value
}

resource "aws_api_gateway_method" "this" {
  for_each = var.methods

  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.this[each.value.path].id

  http_method   = each.value.method
  authorization = "NONE" # TODO: Ver que onda
}

resource "aws_api_gateway_integration" "this" {
  for_each = var.methods

  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.this[each.value.path].id
  http_method = aws_api_gateway_method.this[each.key].http_method
  integration_http_method = aws_api_gateway_method.this[each.key].http_method

  type = "AWS_PROXY"
  uri = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/${each.value.lambda.arn}/invocations"
  # uri = each.value.lambda 
  # var.endpoints[keys(var.endpoints)[count.index]].value.lambda
}


resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    redeployment = sha1(jsonencode([
      # NOTE: The configuration below will satisfy ordering considerations,
      #       but not pick up all future REST API changes. More advanced patterns
      #       are possible, such as using the filesha1() function against the
      #       Terraform configuration file(s) or removing the .id references to
      #       calculate a hash against whole resources. Be aware that using whole
      #       resources will show a difference after the initial implementation.
      #       It will stabilize to only change when resources change afterwards.
      # aws_api_gateway_rest_api.this.body,
      aws_api_gateway_resource.this,
      aws_api_gateway_method.this,
      aws_api_gateway_integration.this,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_lambda_permission" "this" {
  for_each = var.methods

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = each.value.lambda.name
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_deployment.this.execution_arn}/*/*"
}


resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = "DEV"
}
