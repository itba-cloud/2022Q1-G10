resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.role_policy.json
}

resource "aws_iam_policy" "this" {
  name        = var.policy_name
  description = var.policy_description

  policy = data.aws_iam_policy_document.iam_policy.json
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
