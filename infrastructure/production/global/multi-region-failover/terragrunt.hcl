include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = find_in_parent_folders("modules/multi-region-failover")
}

locals {
  global_vars  = read_terragrunt_config(find_in_parent_folders("global.hcl"))
  project_name = local.global_vars.locals.project_name
}

inputs = {
  name = local.project_name
  # The ALB Arn needs to be obtained from AWS manually and add here before provisioning the Global Accelator
  alb_arn_eu_west_1 = ""
  alb_arn_us_east_1 = ""
}