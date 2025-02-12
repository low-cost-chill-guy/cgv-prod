# Subnet Group (AZ-a)
resource "aws_db_subnet_group" "az_a" {
  name       = "${lower(var.db_name)}-subnet-group-az-a"
  subnet_ids = var.subnet_ids_az_a
  tags = {
    Name = "${lower(var.db_name)}-subnet-group-az-a"
  }
}

# Subnet Group (AZ-c)
resource "aws_db_subnet_group" "az_c" {
  name       = "${lower(var.db_name)}-subnet-group-az-c"
  subnet_ids = var.subnet_ids_az_c
  tags = {
    Name = "${lower(var.db_name)}-subnet-group-az-c"
  }
}

# AZ-a Writer Instance
module "aws_rds_writer_az_a" {
  source = "terraform-aws-modules/rds/aws"
  
  identifier = "${lower(var.db_name)}-write-az-a"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  
  manage_master_user_password = false
  
  db_name        = var.db_name
  username       = var.db_username
  port           = var.db_port
  password       = var.db_password
  
  availability_zone = "ap-northeast-2a"
  multi_az         = false
  
  skip_final_snapshot = true
  backup_retention_period = 7
  
  create_db_subnet_group = false
  db_subnet_group_name   = aws_db_subnet_group.az_a.name
  
  family = "mysql8.0"
  major_engine_version = "8.0"

  # Option group 설정
  create_db_option_group = true
  option_group_name     = "${lower(var.db_name)}-opt-write-a"
  option_group_use_name_prefix = false

  # Parameter group 설정
  create_db_parameter_group = true
  parameter_group_name    = "${lower(var.db_name)}-param-write-a"
  parameter_group_use_name_prefix = false
  
  tags = {
    Owner       = "user"
    Environment = "dev"
    Role        = "writer-az-a"
  }
}

# AZ-c Writer Instance
module "aws_rds_writer_az_c" {
  source = "terraform-aws-modules/rds/aws"
  
  identifier = "${lower(var.db_name)}-write-az-c"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  
  manage_master_user_password = false
  
  db_name        = var.db_name
  username       = var.db_username
  port           = var.db_port
  password       = var.db_password
  
  availability_zone = "ap-northeast-2c"
  multi_az         = false
  
  skip_final_snapshot = true
  backup_retention_period = 7
  
  create_db_subnet_group = false
  db_subnet_group_name   = aws_db_subnet_group.az_c.name
  
  family = "mysql8.0"
  major_engine_version = "8.0"

  # Option group 설정
  create_db_option_group = true
  option_group_name     = "${lower(var.db_name)}-opt-write-c"
  option_group_use_name_prefix = false

  # Parameter group 설정
  create_db_parameter_group = true
  parameter_group_name    = "${lower(var.db_name)}-param-write-c"
  parameter_group_use_name_prefix = false
  
  tags = {
    Owner       = "user"
    Environment = "dev"
    Role        = "writer-az-c"
  }
}

# AZ-a Reader Instance
module "aws_rds_reader_az_a" {
  source = "terraform-aws-modules/rds/aws"
  
  identifier = "${lower(var.db_name)}-read-az-a"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  
  port     = var.db_port
  availability_zone = "ap-northeast-2a"
  multi_az         = false
  
  replicate_source_db = module.aws_rds_writer_az_a.db_instance_identifier
  
  family = "mysql8.0"
  major_engine_version = "8.0"

  # Option group 설정
  create_db_option_group = true
  option_group_name     = "${lower(var.db_name)}-opt-read-a"
  option_group_use_name_prefix = false

  # Parameter group 설정
  create_db_parameter_group = true
  parameter_group_name    = "${lower(var.db_name)}-param-read-a"
  parameter_group_use_name_prefix = false
  
  tags = {
    Owner       = "user"
    Environment = "dev"
    Role        = "reader-az-a"
  }
}

# AZ-c Reader Instance
module "aws_rds_reader_az_c" {
  source = "terraform-aws-modules/rds/aws"
  
  identifier = "${lower(var.db_name)}-read-az-c"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  
  port     = var.db_port
  availability_zone = "ap-northeast-2c"
  multi_az         = false
  
  replicate_source_db = module.aws_rds_writer_az_c.db_instance_identifier
  
  family = "mysql8.0"
  major_engine_version = "8.0"

  # Option group 설정
  create_db_option_group = true
  option_group_name     = "${lower(var.db_name)}-opt-read-c"
  option_group_use_name_prefix = false

  # Parameter group 설정
  create_db_parameter_group = true
  parameter_group_name    = "${lower(var.db_name)}-param-read-c"
  parameter_group_use_name_prefix = false
  
  tags = {
    Owner       = "user"
    Environment = "dev"
    Role        = "reader-az-c"
  }
}
