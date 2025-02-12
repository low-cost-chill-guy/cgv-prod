# Availability Zones
variable "azs" {
  description = "Availability Zones for the VPC"
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}

# Prod VPC IPs
variable "vpc_cidr" {
  description = "The Prod CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of Prod Public Subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.5.0/24"]
}

variable "private_subnets_az_a" {
  description = "List of Prod Private Subnets for AZ A"
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
}

variable "private_subnets_az_c" {
  description = "List of Prod Private Subnets for AZ C"
  type        = list(string)
  default     = ["10.0.6.0/24", "10.0.7.0/24", "10.0.8.0/24"]
}
