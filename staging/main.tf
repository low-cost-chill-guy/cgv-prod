# AWS VPC
module "vpc" {
  source = "../module/prod_vpc"
}

# AWS RDS Module
module "rds" {
  source = "../module/prod_rds"
  db_name     = var.db_name
  db_username = var.db_username
  db_port     = var.db_port
  db_password = var.db_password
  subnet_ids_az_a = module.vpc.private_subnet_ids_az_a  # AZ-a의 서브넷 ID
  subnet_ids_az_c = module.vpc.private_subnet_ids_az_c  # AZ-c의 서브넷 ID
  
}

# AZ-a EKS Module
module "eks_az_a" {
  source = "../module/prod_eks"
  
  #cluster_name    = "stage-eks-az-a"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids_az_a
  #availability_zone = "ap-northeast-2a"
}

# AZ-c EKS Module
module "eks_az_c" {
  source = "../module/prod_eks"
  
  #cluster_name    = "stage-eks-az-c"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids_az_c
  #availability_zone = "ap-northeast-2c"
}
