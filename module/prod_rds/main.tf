#Subnet name
resource "aws_db_subnet_group" "az_a" {
  name       = "${var.db_name}-subnet-group-az-a"
  subnet_ids = [var.subnet_ids["az_a"]]

  tags = {
    Name = "${var.db_name}-subnet-group-az-a"
  }
}

resource "aws_db_subnet_group" "az_c" {
  name       = "${var.db_name}-subnet-group-az-c"
  subnet_ids = [var.subnet_ids["az_c"]]

  tags = {
    Name = "${var.db_name}-subnet-group-az-c"
  }
}
# AZ-a Writer Instance
module "aws_rds_writer_az_a" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${var.db_name}-write-az-a"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = var.db_name
  username = var.db_username
  port     = var.db_port

  availability_zone = "ap-northeast-2a"
  multi_az         = false
  skip_final_snapshot  = true
  backup_retention_period = 7
  create_db_subnet_group = false
  db_subnet_group_name   = aws_db_subnet_group.az_a.name

  tags = {
    Owner       = "user"
    Environment = "dev"
    Role        = "writer-az-a"
  }
}

# AZ-a Reader Instance
module "aws_rds_reader_az_a" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${var.db_name}-read-az-a"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = var.db_name
  username = var.db_username
  port     = var.db_port

  availability_zone = "ap-northeast-2a"
  multi_az         = false
  replicate_source_db = module.aws_rds_writer_az_a.db_instance_id

  create_db_subnet_group = true
  subnet_ids             = [var.subnet_ids["az_a"]]

  tags = {
    Owner       = "user"
    Environment = "dev"
    Role        = "reader-az-a"
  }
}

# AZ-c Writer Instance
module "aws_rds_writer_az_c" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${var.db_name}-write-az-c"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = var.db_name
  username = var.db_username
  port     = var.db_port

  availability_zone = "ap-northeast-2c"
  multi_az         = false
  skip_final_snapshot  = true
  backup_retention_period = 7
  create_db_subnet_group = false
  db_subnet_group_name   = aws_db_subnet_group.az_c.name

  tags = {
    Owner       = "user"
    Environment = "dev"
    Role        = "writer-az-c"
  }
}

# AZ-c Reader Instance
module "aws_rds_reader_az_c" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${var.db_name}-read-az-c"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = var.db_name
  username = var.db_username
  port     = var.db_port

  availability_zone = "ap-northeast-2c"
  multi_az         = false
  replicate_source_db = module.aws_rds_writer_az_c.db_instance_id

  create_db_subnet_group = true
  subnet_ids             = [var.subnet_ids["az_c"]]

  tags = {
    Owner       = "user"
    Environment = "dev"
    Role        = "reader-az-c"
  }
}
