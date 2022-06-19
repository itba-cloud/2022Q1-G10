# ---------------------------------------------------------------------------
# Amazon S3 datasources
# ---------------------------------------------------------------------------

data "aws_iam_policy_document" "this" {
    statement {
        sid = "PublicReadGetObject"
        effect = var.policy.statement.effect
        actions = var.policy.statement.actions
        principals {
            type        = var.policy.statement.principal.type
            identifiers = var.policy.statement.principal.identifiers
        }
        resources = ["${aws_s3_bucket.this.arn}/*"]
    }
}
