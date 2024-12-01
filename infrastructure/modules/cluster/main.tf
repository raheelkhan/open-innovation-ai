module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.29.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  cluster_endpoint_private_access      = true

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  eks_managed_node_group_defaults = {
    min_size     = var.min_size
    max_size     = var.max_size
    desired_size = var.desired_size
  }

  eks_managed_node_groups = {
    cpu = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]
      labels = {
        "open.innovation.ai/node-type" = "cpu"
      }
    }
    gpu = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["p3.2xlarge"]
      labels = {
        "open.innovation.ai/node-type" = "gpu"
      }
    }
  }

  enable_cluster_creator_admin_permissions = true

  tags = {
    Environment = var.environment
  }
}