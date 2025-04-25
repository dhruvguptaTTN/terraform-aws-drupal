locals {
  name = "complete-mysql"
  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}

module "terraform-aws-rds-source" {
  source  = "terraform-aws-modules/rds/aws"
  version = "latest"

  identifier         = "mysql-group-source"
  engine             = var.rds_engine
  engine_version     = var.rds_engine_version
  instance_class     = var.rds_instance_class
  allocated_storage  = var.rds_allocated_storage
  max_allocated_storage = var.rds_max_allocated_storage
  name               = var.rds_name
  username           = var.rds_username
  password           = var.rds_password
  port               = var.rds_port
  parameter_group_name = var.rds_parameter_group_name
  create_db_parameter_group = var.rds_create_db_parameter_group
  create_db_option_group    = var.rds_create_db_option_group

  maintenance_window = var.rds_maintenance_window
  backup_window      = var.rds_backup_window
  backup_retention_period = var.rds_backup_retention_period
  skip_final_snapshot = var.rds_skip_final_snapshot

  subnet_ids             = var.subnet_rds
  vpc_security_group_ids = var.sec_group_rds
}

output "rds_endpoint" {
  value = module.terraform-aws-rds-source.db_instance_endpoint
}
