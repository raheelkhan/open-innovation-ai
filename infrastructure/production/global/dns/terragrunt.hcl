include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = find_in_parent_folders("modules/dns")
}

dependency "multi-region-failover" {
  config_path  = "../multi-region-failover"
  skip_outputs = true
  mock_outputs = {
    dns_name       = "x"
    hosted_zone_id = "x"
  }
}

inputs = {
  domain_name                    = "example.com"
  global_accelerator_dns_name    = dependency.multi-region-failover.outputs.dns_name
  global_accelerator_hosted_zone = dependency.multi-region-failover.hosted_zone_id
}