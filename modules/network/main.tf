locals {
  name = "demo-vpc"
}

module "vpc" {
  source = "https://github.com/terraform-aws-modules/terraform-aws-vpc.git"

  name             = local.name
  cidr             = var.cidr
  azs              = var.azs
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
}

module "security_group_asg" {
  source = "https://github.com/terraform-aws-modules/terraform-aws-autoscaling.git"

  name   = "security-group_asg"
  vpc_id = module.vpc.vpc_id
  egress_with_cidr_blocks = var.egress_with_cidr_blocks
  ingress_with_cidr_blocks = var.ingress_with_cidr_blocks
}

module "security_group_rds" {
  source = "https://github.com/terraform-aws-modules/terraform-aws-security-group.git"

  name   = "security-group_rds"
  vpc_id = module.vpc.vpc_id
  egress_with_cidr_blocks = var.egress_with_cidr_blocks
  ingress_with_cidr_blocks = var.ingress_with_cidr_blocks

  computed_ingress_with_source_security_group_id = var.computed_ingress_with_source_security_group_id
  number_of_computed_ingress_with_source_security_group_id = var.number_of_computed_ingress_with_source_security_group_id
}
