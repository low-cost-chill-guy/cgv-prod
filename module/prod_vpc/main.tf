module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name            = "prod-vpc"
  cidr            = var.vpc_cidr

  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = flatten([var.private_subnets_az_a, var.private_subnets_az_c]) 
  
  enable_nat_gateway  = false
  #enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "prod"
    Name        = "prod-vpc"
  }
}
