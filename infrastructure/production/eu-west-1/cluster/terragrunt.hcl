include "root" {
  path = find_in_parent_folders()
}

locals {
  global_vars  = read_terragrunt_config(find_in_parent_folders("global.hcl"))
  project_name = local.global_vars.locals.project_name
}

terraform {
  source = find_in_parent_folders("modules/cluster")
}

dependency "network" {
  config_path  = "../network"
  skip_outputs = true
  mock_outputs = {
    vpc_id              = "x"
    private_subnets_ids = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  }

}

inputs = {
  cluster_name                         = "${local.project_name}-cluster"
  cluster_version                      = "1.31.0"
  cluster_endpoint_public_access_cidrs = ["2.49.157.196"]
  vpc_id                               = dependency.network.outputs.vpc_id
  subnet_ids                           = dependency.network.outputs.private_subnets_ids
  min_size                             = 1
  max_size                             = 3
  desired_size                         = 3
}