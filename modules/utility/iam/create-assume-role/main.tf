data "aws_iam_policy_document" "assume_role" {
  statement {
    sid     = "Assume${var.role}"
    actions = ["sts:AssumeRole"]

    resources = [
      "arn:aws:iam::${var.account_id}:role/${var.role}",
    ]
  }
}

resource "aws_iam_policy" "assume_role" {
  name        = "Assume${var.role}"
  policy      = data.aws_iam_policy_document.assume_role.json
  description = "Grants role assumption for the ${title(var.role)} role in the ${title(var.account_name)} account"
}
