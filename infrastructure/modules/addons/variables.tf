variable "cluster_name" {
  type = string
}

variable "cluster_identity_oidc_issuer" {
  type        = string
  description = "The Name OIDC Identity issuer for the cluster"
}

variable "cluster_identity_oidc_issuer_arn" {
  type        = string
  description = "The ARN OIDC Identity issuer for the cluster"
}
