resource "aws_organizations_organization" "organisation" {
  feature_set = "ALL"

  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "config-multiaccountsetup.amazonaws.com"
  ]

  lifecycle {
    prevent_destroy = true
  }
}

module "assume_role_organisation_admin" {
  source = "../../iam/create-role-with-assume"

  account_name            = "org"
  account_id              = data.aws_caller_identity.current.account_id
  assume_role_policy_json = data.aws_iam_policy_document.assume_from_organisation.json
  role                    = "Administrator"
  role_policy_arn         = "arn:aws:iam::aws:policy/AdministratorAccess"
  tags                    = var.tags
}
