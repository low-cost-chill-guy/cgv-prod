module "vpc" {
  source = "../module/prod_vpc"
}
# aws_staging
module "rds" {
  source = "../modules/prod_rds"
 
   subnet_ids = {
    az_a =   # AZ-a의 서브넷 ID
    az_c =   # AZ-c의 서브넷 ID
  }
}
