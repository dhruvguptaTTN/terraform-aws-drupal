variable "vpc_alb" {
  description = "The VPC ID where the ALB will be created."
  type        = string
}

variable "subnet_alb" {
  description = "A list of subnet IDs for the ALB."
  type        = list(string)
}

variable "sec_group_alb" {
  description = "Security group for the ALB."
  type        = string
}

variable "target_gp" {
  description = "Target group settings for the ALB."
  type = object({
    backend_protocol = string
    backend_port     = number
    target_type      = string
    health_check = object({
      enabled             = bool
      interval            = number
      path                = string
      port                = string
      healthy_threshold   = number
      unhealthy_threshold = number
      timeout             = number
      protocol            = string
      matcher             = string
    })
  })
  default = {
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
}

variable "http_tcp_listeners" {
  description = "Listener configuration for the ALB."
  type = list(object({
    port               = number
    protocol           = string
    target_group_index = number
    action_type        = string
  }))
  default = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
      action_type        = "forward"
    }
  ]
}

variable "tags" {
  description = "Tags to associate with the ALB."
  type = map(string)
  default = {
  Project = "terraform_drupal"

  }
}


