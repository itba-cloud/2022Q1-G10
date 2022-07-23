# 1 - S3 bucket
resource "aws_s3_bucket" "this" {
    bucket              = var.bucket_name
    object_lock_enabled = false
}

# 2 - S3 bucket policy
resource "aws_s3_bucket_policy" "this" {
    bucket = aws_s3_bucket.this.id
    policy = var.policy == "public_read" ? data.aws_iam_policy_document.public_read.json : data.aws_iam_policy_document.lambda_only.json
}

# 3 -Website configuration
resource "aws_s3_bucket_website_configuration" "web" {
    count = var.is_website ? 1 : 0
    bucket = aws_s3_bucket.this.id

    index_document {
        suffix = "index.html"
    }

    error_document {
        key = "error.html"
    }
}

resource "aws_s3_bucket_website_configuration" "redirect" {
    count = var.is_redirect ? 1 : 0
    bucket = aws_s3_bucket.this.id
    redirect_all_requests_to {
        host_name = var.redirect
    }
}
# 4 - Access Control List
resource "aws_s3_bucket_acl" "this" {
    bucket = aws_s3_bucket.this.id
    acl    = var.bucket_acl
}

# 5 - Upload objects
resource "aws_s3_object" "this" {
    for_each =  try(var.objects, {}) 

    bucket        = aws_s3_bucket.this.id
    key           = try(each.value.rendered, replace(each.value.filename, "html/", "")) # remote path
    source        = try(each.value.rendered, format("./resources/%s", each.value.filename)) # where is the file located
    content_type  = each.value.content_type
    storage_class = try(each.value.tier, "STANDARD")
}
