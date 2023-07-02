terraform {
  backend "s3" {
    bucket = "terraformpasswordpusherstate"
    key    = "state-dev.tfstate"
    region = "eu-central-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5.0"
    }
  }

  required_version = "= 1.5.1"
}


provider "aws" {
  region = "eu-central-1"
}

module "main" {
  source          = "../modules"
  container_image = var.container_image
  environment     = "dev"
  domain_name     = var.domain_name
  r53_zone_id     = var.r53_zone_id
}

variable "container_image" {
  type        = string
  description = "Docker image for ECS task"
}

variable "domain_name" {
  type        = string
  description = "Domain name"
}

variable "r53_zone_id" {
  type        = string
  description = "Route 53 Hosted Zone Id"
}