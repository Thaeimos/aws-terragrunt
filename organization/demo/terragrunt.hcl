terraform {
  source = "${find_in_parent_folders("modules")}/account"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  account_name  = basename(get_terragrunt_dir())
  account_email = "test4t45t45t54@email.com"
  org_unit_id   = "ou-89gl-npbrutkg"
}