# Network Module Values
vpc_id_all          = "vpc-0123456789abcdef0"
public_sn_asg       = ["10.99.0.0/24", "10.99.1.0/24", "10.99.2.0/24"]
private_sn_asg      = ["10.99.3.0/24", "10.99.4.0/24", "10.99.5.0/24"]
security_group_id_asg = "sg-0123456789abcdef0"
security_group_id_rds = "sg-0123456789abcdef1"
security_group_id_efs = "sg-0123456789abcdef2"

# DB Module Values
vpc_asg             = "vpc-0123456789abcdef0"
sec_group_rds       = "sg-0123456789abcdef1"
subnet_rds          = ["10.99.3.0/24", "10.99.4.0/24"]

# ASG Module Values
subnet_asg          = ["10.99.0.0/24", "10.99.1.0/24", "10.99.2.0/24"]
sec_group_asg       = "sg-0123456789abcdef0"
rds_point           = "rds-instance-endpoint"
target_gp           = "target-group-arn"
dns_name            = "efs.example.com"

# ALB Module Values
vpc_alb             = "vpc-0123456789abcdef0"
sec_group_alb       = "sg-0123456789abcdef0"
subnet_alb          = ["10.99.0.0/24", "10.99.1.0/24", "10.99.2.0/24"]

# EFS Module Values
subnet_efs          = ["10.99.3.0/24", "10.99.4.0/24"]
sec_group_efs       = "sg-0123456789abcdef2"
vpc_efs             = "vpc-0123456789abcdef0"

# Route 53 Module Values
dns_alb             = "alb.example.com"
vpc_route53         = "vpc-0123456789abcdef0"
