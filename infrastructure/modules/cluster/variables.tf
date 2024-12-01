variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "environment" {
  type        = string
  description = "Environment such as production, staging etc"
}

variable "min_size" {
  type        = number
  description = "Minimum number of worker nodes in a node group"
}

variable "max_size" {
  type        = number
  description = "Minimum number of worker nodes in a node group"
}

variable "desired_size" {
  type        = number
  description = "Desired number of worker nodes in a node group"
}

variable "cluster_endpoint_public_access_cidrs" {
  type        = list(string)
  description = "CIDR to allow access to cluster endpoint"
}
