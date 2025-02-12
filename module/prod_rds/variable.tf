# aws_prod_variable
variable "db_name" {
  description = "The name of the database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "db_username" {
  description = "Username for the master DB user"
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = "3306"
  sensitive   = true
}

variable "subnet_ids" {
  description = "Map of subnet IDs for each AZ"
  type        = map(string)
}
