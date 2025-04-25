# Network Module Variables
variable "vpc_id_all" {
  description = "VPC ID for the entire setup."
  type        = string
}

variable "public_sn_asg" {
  description = "Public subnets for the ASG."
  type        = list(string)
}

variable "private_sn_asg" {
  description = "Private subnets for the ASG."
  type        = list(string)
}

variable "security_group_id_asg" {
  description = "Security group ID for the ASG."
  type        = string
}

variable "security_group_id_rds" {
  description = "Security group ID for the RDS instance."
  type        = string
}

variable "security_group_id_efs" {
  description = "Security group ID for EFS."
  type        = string
}

# DB Module Variables
variable "vpc_asg" {
  description = "VPC ID for the DB module."
  type        = string
}

variable "sec_group_rds" {
  description = "Security group ID for RDS."
  type        = string
}

variable "subnet_rds" {
  description = "Subnets for the RDS module."
  type        = list(string)
}

# ASG Module Variables
variable "subnet_asg" {
  description = "Subnets for the ASG module."
  type        = list(string)
}

variable "sec_group_asg" {
  description = "Security group ID for the ASG module."
  type        = string
}

variable "rds_point" {
  description = "RDS endpoint for the ASG module."
  type        = string
}

variable "target_gp" {
  description = "Target group for the ASG module."
  type        = string
}

variable "dns_name" {
  description = "DNS name for the EFS module."
  type        = string
}

# ALB Module Variables
variable "vpc_alb" {
  description = "VPC ID for the ALB module."
  type        = string
}

variable "sec_group_alb" {
  description = "Security group ID for the ALB module."
  type        = string
}

variable "subnet_alb" {
  description = "Subnets for the ALB module."
  type        = list(string)
}

# EFS Module Variables
variable "subnet_efs" {
  description = "Subnets for the EFS module."
  type        = list(string)
}

variable "sec_group_efs" {
  description = "Security group ID for the EFS module."
  type        = string
}

variable "vpc_efs" {
  description = "VPC ID for the EFS module."
  type        = string
}

# Route 53 Module Variables
variable "dns_alb" {
  description = "DNS name for the ALB module."
  type        = string
}

variable "vpc_route53" {
  description = "VPC ID for the Route53 module."
  type        = string
}
