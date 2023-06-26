terraform {
  # backend "s3" {
  #       bucket = "terraformpasswordpusherstate"
  #       key    = "state-dev.tfstate"
  #       region = "eu-central-1"
  #   }
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
  source      = "../modules"
  environment = "dev"
  container_tag = var.container_tag

  providers = {
    aws = aws,
    aws.dev = aws
  }
}

variable "container_tag" {}
locals {
  app_name = "password-pusher"
}