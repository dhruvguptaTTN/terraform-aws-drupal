module "alb" {
  # Correct source URL from the GitHub repository
 source  = "git::https://github.com/terraform-aws-modules/terraform-aws-alb.git?ref=v6.0.0"
  version = "v8.0.0"  # Latest version tag or update according to your need

  name = "group-alb"

  # The type of Load Balancer
  load_balancer_type = "application"

  # Reference VPC and subnet
  vpc_id          = var.vpc_alb
  subnets         = var.subnet_alb
  security_groups = [var.sec_group_alb]

  # Target Group Configuration
  target_groups = [
    {
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
  ]

  # HTTP Listener Configuration
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
      action_type        = "forward"
    }
  ]

  # Adding Tags for the Load Balancer
  tags = {
    Project = "terraform_drupal"
  }
}

# Output for Target Group ARN
output "tg" {
  value = module.alb.target_group_arns
}

# Output for DNS Name of the ALB
output "dns" {
  value = module.alb.lb_dns_name
}
