module "create_role" {
  source = "https://github.com/Thaeimos/aws-terragrunt.git//modules/utility/iam/create-role"

  account_name            = var.account_name
  assume_role_policy_json = var.assume_role_policy_json
  role                    = var.role
  role_policy_arn         = var.role_policy_arn
  tags                    = var.tags
}

module "assume_role" {
  source = "https://github.com/Thaeimos/aws-terragrunt.git//modules/utility/iam/create-assume-role"

  account_name = var.account_name
  account_id   = var.account_id
  role         = module.create_role.name
}

