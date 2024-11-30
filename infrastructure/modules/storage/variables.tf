variable "private_subnets_eu_west_1" {
  type = list(string)
}

variable "private_subnets_us_east_1" {
  type = list(string)
}

variable "environment" {
  type        = string
  description = "Environment such as production, staging etc"
}
