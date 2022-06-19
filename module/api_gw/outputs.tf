output "id" {
    value = aws_api_gateway_rest_api.this.id
}

output "arn" {
    value = aws_api_gateway_deployment.this.execution_arn
}

output "url" {
    value = aws_api_gateway_deployment.this.invoke_url
}