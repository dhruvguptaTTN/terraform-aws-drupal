# VPC Configuration
vpc_cidr_block = "10.99.0.0/18"
azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
public_subnets  = ["10.99.0.0/24", "10.99.1.0/24", "10.99.2.0/24"]
private_subnets = ["10.99.3.0/24", "10.99.4.0/24", "10.99.5.0/24"]

# Security Group ASG Configuration
sec_group_asg_name = "security-group_asg"
sec_group_asg_ingress = [
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = "110.235.219.73/32"
  },
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "SSH"
    cidr_blocks = "110.235.219.73/32"
  },
  {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    description = "NFS"
    cidr_blocks = "110.235.219.73/32"
  },
  {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    description = "ALB Port Open in ASG"
    cidr_blocks = "10.99.0.0/18"
  },
  {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = "110.235.219.73/32"
  }
]

# Security Group RDS Configuration
sec_group_rds_name = "security-group_rds"
sec_group_rds_ingress = [
  {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    description = "All TCP"
    cidr_blocks = "110.235.219.73/32"
  }
]
sec_group_rds_computed_ingress = [
  {
    from_port                = 3306
    to_port                  = 3306
    protocol                 = "tcp"
    description              = "Added ASG SG"
    source_security_group_id = "security_group_asg_id_placeholder"
  }
]

# RDS Configuration
rds_identifier        = "mysql-group-source"
rds_engine            = "mysql"
rds_engine_version    = "8.0" # Adjust based on your preference for version
rds_instance_class    = "db.m4.medium"
rds_allocated_storage = 50
rds_max_allocated_storage = 100
rds_name              = "mydb_source"
rds_username          = "drupaladmin"
rds_password          = "redhat22"
rds_port              = 3306
rds_parameter_group_name = "default.mysql8.0"
