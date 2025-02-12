#aws_staging_variable
variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_username" {
  type        = string
  description = "Database username"
}

variable "db_password" {
  type        = string
  description = "Database password"
  sensitive   = true
}

variable "db_port" {
  type       = string
  description = "Database port"
  sensitive   = true
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for az-a and az-c"
}

