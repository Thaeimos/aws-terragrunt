terraform {
  source = "tfr:///terraform-aws-modules/vpc/aws//?version=5.8.1"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name            = "${include.root.locals.org_vars.locals.aws_org}-${include.root.locals.account_vars.locals.account_name}-${include.root.locals.region_vars.locals.aws_region}-${include.root.locals.env_vars.locals.env}-vpc"
  cidr            = include.root.locals.vpc_cidr
  azs             = ["${include.root.locals.region_vars.locals.aws_region}a", "${include.root.locals.region_vars.locals.aws_region}b"]
  // azs             = [ for s in range(include.root.locals.number_azs) : "${include.root.locals.region_vars.locals.aws_region}-" ]
  private_subnets = [ for s in range(include.root.locals.number_azs) : cidrsubnet(include.root.locals.vpc_cidr, 8, s) ]
  
  public_subnets  = [ for s in range(include.root.locals.number_azs) : cidrsubnet(include.root.locals.vpc_cidr, 8, s + include.root.locals.number_azs) ]
}