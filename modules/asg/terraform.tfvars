# terraform.tfvars

# The endpoint for the RDS database to connect the Auto Scaling Group instances
rds_point   = "mydb.example.com"

# Security Group IDs for the Auto Scaling Group instances
sec_group_asg = [
  "sg-12345678",  # First security group
  "sg-87654321"   # Second security group
]

# Subnet IDs for the Auto Scaling Group instances
subnet_asg = [
  "subnet-abcdefg",  # First subnet
  "subnet-hijklmn"   # Second subnet
]

# Target Group ARN(s) for load balancing
target_gp = [
  "arn:aws:elasticloadbalancing:region:account-id:targetgroup/my-target-group"
]

# The AMI ID for the Auto Scaling Group instances
img_id = "ami-12345678"
