resource "aws_iam_role" "role" {
  name               = "${replace(title(var.account_name), "/-| /", "")}${replace(title(var.role), "/-| /", "")}AccessRole"
  assume_role_policy = var.assume_role_policy_json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "role_policy" {
  role       = aws_iam_role.role.name
  policy_arn = var.role_policy_arn
}
