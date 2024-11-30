variable "domain_name" {
  type        = string
  description = "Domain name for frontend application"
}

variable "global_accelerator_dns_name" {
  type        = string
  description = "Global Accelerator DNS name"
}


variable "global_accelerator_hosted_zone" {
  type        = string
  description = "Global Accelerator hosted zone ID"
}

