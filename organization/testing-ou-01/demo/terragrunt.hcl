terraform {
  source = "${find_in_parent_folders("modules")}/account"
}

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependency "org_unit" {
  config_path = "${get_terragrunt_dir()}/../"

  mock_outputs = {
    org_unit_id = "mock-ou-name"
  }

  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

locals {
  uuid = uuid()
}

inputs = {
  account_name  = basename(get_terragrunt_dir())
  account_email = "${local.uuid}@email.com"
  org_unit_id   = dependency.org_unit.outputs.org_unit_id
}
