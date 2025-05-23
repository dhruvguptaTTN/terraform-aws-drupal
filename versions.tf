terraform {
  required_version = ">= 1.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.95.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1"
    }
  }
}

