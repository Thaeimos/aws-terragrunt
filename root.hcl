locals {
  account_vars  = try(read_terragrunt_config(find_in_parent_folders("account.hcl")), {})
  env_vars      = try(read_terragrunt_config(find_in_parent_folders("env.hcl")), {})
  region_vars   = try(read_terragrunt_config(find_in_parent_folders("region.hcl")), {})
  org_unit_vars = try(read_terragrunt_config(find_in_parent_folders("org_unit.hcl")), {})
  org_vars      = try(read_terragrunt_config(find_in_parent_folders("organization.hcl")), {})
  vpc_cidr      = "10.0.0.0/8"
  number_azs    = ["a", "b", "c"]
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "tfstate.example.com"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-locks"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region  = "${try(local.region_vars.locals.aws_region, "us-east-1")}"
  %{ if try(local.region_vars.locals.region, false) }
  assume_role {
    role_arn = "arn:aws:iam::${try(local.account_vars.locals.aws_region)}:role/terragrunt-role"
  }
  %{ endif }
}
EOF
}

// generate "provider_version" {
//   path      = "versions.tf"
//   if_exists = "overwrite_terragrunt"
//   contents  = <<EOF
// terraform {
//   required_providers {
//     aws = {
//       source  = "hashicorp/aws"
//       version = "~> 5.0"
//     }
//   }
// }
// EOF
// }

# Centralized cache
terraform {
  before_hook "before_cache" {
    commands = [get_terraform_command()]
    execute  = ["mkdir", "-p", abspath("${get_repo_root()}/.terragrunt-cache/.plugins")]
  }
  extra_arguments "terragrunt_plugins" {
    commands = [get_terraform_command()]
    env_vars = {
      TF_PLUGIN_CACHE_DIR = abspath("${get_repo_root()}/.terragrunt-cache/.plugins")
    }
  }
}
download_dir = abspath("${get_repo_root()}/.terragrunt-cache")