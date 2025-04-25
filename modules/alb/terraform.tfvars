vpc_alb = "vpc-xxxxxxxx"  # Replace with your VPC ID

subnet_alb = [
  "subnet-xxxxxxxx",  # Replace with your subnet IDs
  "subnet-yyyyyyyy"
]

sec_group_alb = "sg-xxxxxxxx"  # Replace with your security group ID

target_gp = {
  backend_protocol = "HTTP"
  backend_port     = 80
  target_type      = "instance"
  health_check = {
    enabled             = true
    interval            = 110
    path                = "/drupal"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 100
    protocol            = "HTTP"
    matcher             = "200-399"
  }
}

http_tcp_listeners = [
  {
    port               = 80
    protocol           = "HTTP"
    target_group_index = 0
    action_type        = "forward"
  }
]

tags = {
  Project = "terraform_drupal"
}
