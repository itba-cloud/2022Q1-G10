resource "aws_api_gateway_rest_api" "this" {
  name = var.name
}

# resource "aws_api_gateway_resource" "this" {
#   for_each = var.endpoints

#   parent_id   = aws_api_gateway_rest_api.this.root_resource_id
#   rest_api_id = aws_api_gateway_rest_api.this.id
#   path_part   = each.value
# }

resource "aws_api_gateway_resource" "parents" {
  for_each = toset([ for resource in var.resources: resource.path if resource.parent == "" ])

  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.this.id
  path_part   = each.value
}

resource "aws_api_gateway_resource" "children" {
  for_each = { for resource in var.resources: "${resource.parent}/${resource.path}" => resource if resource.parent != "" }

  parent_id   = aws_api_gateway_resource.parents[each.value.parent].id
  rest_api_id = aws_api_gateway_rest_api.this.id
  path_part   = each.value.path
}
resource "aws_api_gateway_method" "this" {
  for_each = var.methods

  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = lookup(aws_api_gateway_resource.parents, each.value.path, false) != false ? aws_api_gateway_resource.parents[each.value.path].id : aws_api_gateway_resource.children[each.value.full_path].id

  http_method   = each.value.method
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "this" {
  for_each = var.methods

  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id = lookup(aws_api_gateway_resource.parents, each.value.path, false) != false ? aws_api_gateway_resource.parents[each.value.path].id : aws_api_gateway_resource.children[each.value.full_path].id
  http_method             = aws_api_gateway_method.this[each.key].http_method
  integration_http_method = "POST"

  type = "AWS_PROXY"
  uri  = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/${each.value.lambda.arn}/invocations"
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
      aws_api_gateway_resource.parents,
      aws_api_gateway_resource.children,
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


resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = "DEV"
}
