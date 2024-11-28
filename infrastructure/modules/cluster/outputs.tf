output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_identity_oidc_issuer" {
  value = module.eks.oidc_provider
}

output "cluster_identity_oidc_issuer_arn" {
  value = module.eks.oidc_provider_arn
}
