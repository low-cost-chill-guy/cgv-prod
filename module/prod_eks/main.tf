module "eks_az_a" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = "${local.cluster_name}-az-a"
  cluster_version = "1.31"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  # EKS Auto Mode (Cluster Compute Config)
  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
    Zone        = "az-a"
  }
}

module "eks_az_c" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = "${local.cluster_name}-az-c"
  cluster_version = "1.31"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  # EKS Auto Mode (Cluster Compute Config)
  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
    Zone        = "az-c"
  }
}

locals {
  cluster_name = "stage-eks"
}

