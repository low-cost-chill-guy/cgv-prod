module "vpc" {
  source = "../module/prod_vpc"
}

module "rds" {
  source = "../module/prod_rds"
  db_name     = var.db_name
  db_username = var.db_username
  db_port     = var.db_port
  db_password = var.db_password
  subnet_ids = {
    az_a = module.vpc.private_subnet_ids_az_a  # AZ-a의 서브넷 ID
    az_c = module.vpc.private_subnet_ids_az_c  # AZ-c의 서브넷 ID
  }
}
