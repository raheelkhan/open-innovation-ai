variable "name" {
  type = string
  description = "Name of VPC"
}

variable "cidr" {
  type = string
  description = "CIDR for the VPC"
}

variable "azs" {
  type = list(string)
  description = "Availibity zones"
}

variable "private_subnets" {
  type = list(string)
  description = "CIDR for subnets used for worker nodes"
}

variable "public_subnets" {
  type = list(string)
  description = "CIDR for subnets used for load balancer and other public facing components"
}

variable "environment" {
  type = string
  description = "Environment such as production, staging etc"
}