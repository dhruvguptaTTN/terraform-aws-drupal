# variables.tf

# The endpoint for the RDS database, used by the Auto Scaling Group to connect to the database
variable "rds_point" {
  description = "The RDS endpoint to be used by the Auto Scaling Group for database connection"
  type        = string
}

# Security Group ID(s) for the Auto Scaling Group instances
variable "sec_group_asg" {
  description = "The security group IDs to be associated with the Auto Scaling Group instances"
  type        = list(string)
}

# Subnet ID(s) for the Auto Scaling Group instances
variable "subnet_asg" {
  description = "The subnet IDs where the Auto Scaling Group instances will be deployed"
  type        = list(string)
}

# Target Group ARN(s) for the Auto Scaling Group to register instances with a load balancer
variable "target_gp" {
  description = "The ARN(s) of the target group(s) to register the instances with"
  type        = list(string)
}

# The AMI ID for the Auto Scaling Group instances
variable "img_id" {
  description = "The AMI ID to be used for the Auto Scaling Group instances"
  type        = string
}
