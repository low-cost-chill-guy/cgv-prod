# VPC Outputs
output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The Prod VPC ID"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnets
  description = "List of Prod Public Subnet IDs"
}

output "private_subnet_ids_az_a" {
  value       = slice(module.vpc.private_subnets, 0, 3)
  description = "List of Prod Private Subnet IDs for AZ A"
}

output "private_subnet_ids_az_c" {
  value       = slice(module.vpc.private_subnets, 3, 6)
  description = "List of Prod Private Subnet IDs for AZ C"
}
