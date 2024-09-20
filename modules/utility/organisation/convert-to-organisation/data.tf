data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "assume_from_organisation" {
  statement {
    sid     = "AssumeFromOrganisation"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
      ]
    }
  }
}
