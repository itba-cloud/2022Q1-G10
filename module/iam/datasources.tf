data "aws_iam_policy_document" "role_policy" {
    statement {
        sid = "RolePolicyStatement"
        effect = "Allow"
        actions = ["sts:AssumeRole"]
        principals {
            type = "AWS"
            identifiers = ["lambda.amazonaws.com"]
        }
        resources = ["*"]
    }
}

data "aws_iam_policy_document" "iam_policy" {
    statement {
        sid = "IamPolicyStatement"
        effect = "Allow"
        actions = ["lambda:Describe*"]
        resources = ["*"]
    }
}

