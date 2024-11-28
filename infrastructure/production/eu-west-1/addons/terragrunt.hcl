include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = find_in_parent_folders("modules/addons")
}

dependency "cluster" {
  config_path  = "../cluster"
  skip_outputs = true
}

inputs = {
  cluster_name = dependency.cluster.outputs.cluster_name
  cluster_identity_oidc_issuer = dependency.cluster.outputs.cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = dependency.cluster.outputs.cluster_identity_oidc_issuer_arn
}