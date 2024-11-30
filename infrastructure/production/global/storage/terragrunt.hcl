include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = find_in_parent_folders("modules/storage")
}

locals {
  global_vars  = read_terragrunt_config(find_in_parent_folders("global.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  profile     = local.global_vars.locals.profile
  environment = local.account_vars.locals.environment
  account_id  = local.account_vars.locals.aws_account_id

  default_tags = {
    Terraform   = "true"
    Environment = local.environment
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
  profile = "${local.profile}"

  default_tags {
    tags = ${jsonencode(local.default_tags)}
  }

  allowed_account_ids = ["${local.account_id}"]
}

provider "aws" {
  region = "us-east-1"
  alias = "us-east-1"
  profile = "${local.profile}"

  default_tags {
    tags = ${jsonencode(local.default_tags)}
  }

  allowed_account_ids = ["${local.account_id}"]
}
EOF
}

inputs = {
  private_subnets_eu_west_1 = ["subnet", "ids", "from", "eu-west-1", "private"]
  private_subnets_us_east_1 = ["subnet", "ids", "from", "us-east-1", "private"]
}