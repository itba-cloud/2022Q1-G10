# ---------------------------------------------------------------------------
# Amazon S3 datasources
# ---------------------------------------------------------------------------

data "aws_iam_policy_document" "public_read" {
    statement {
        sid = "PublicReadGetObject"
        effect = "Allow"
        actions = ["s3:GetObject"]
        principals {
            type = "AWS"
            identifiers = ["*"]
        }
        resources = ["${aws_s3_bucket.this.arn}/*"]
    }
}

data "aws_iam_policy_document" "lambda_only" {
    statement {
        sid = "LambdaOnly"
        effect = "Allow"
        actions = ["s3:GetObject"]
        principals {
            type = "AWS"
            identifiers = var.lambda_arns
        }
        resources = ["${aws_s3_bucket.this.arn}/*"]
    }
}
