output "functions" {
    value = {for fn in aws_lambda_function.this: fn.function_name => {
        name = fn.function_name
        arn = fn.arn
    }}
}   