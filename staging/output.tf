output "private_subnet_ids_az_a" {
  value       = module.vpc.private_subnet_ids_az_a
  description = "List of Staging Private Subnet IDs for AZ A"
}

output "private_subnet_ids_az_c" {
  value       = module.vpc.private_subnet_ids_az_c
  description = "List of Staging Private Subnet IDs for AZ C"
}
