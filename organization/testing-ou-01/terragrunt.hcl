terraform {
  source = "${find_in_parent_folders("modules")}/org-unit"
}

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

inputs = {
  org_unit_name = basename(get_terragrunt_dir())
  org_id        = include.root.locals.org_vars.locals.aws_org
}