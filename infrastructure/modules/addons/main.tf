module "alb_controller" {
  source  = "campaand/alb-ingress-controller/aws"
  version = "~> 2.0"

  cluster_name         = var.cluster_name
  use_eks_pod_identity = true
}

module "eks-cluster-autoscaler" {
  source  = "lablabs/eks-cluster-autoscaler/aws"
  version = "2.2.0"

  cluster_identity_oidc_issuer     = var.cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = var.cluster_identity_oidc_issuer_arn
  cluster_name                     = var.cluster_name
}

module "eks-prometheus" {
  source  = "lablabs/eks-prometheus/aws"
  version = "1.0.0"

  cluster_identity_oidc_issuer     = var.cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = var.cluster_identity_oidc_issuer_arn
}

