terraform {
  backend "s3" {
    bucket = "terraformpasswordpusherdevstate"
    key    = "state-dev.tfstate"
    region = "eu-central-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5.0"
    }
    newrelic = {
      source = "newrelic/newrelic"
    }
  }

  required_version = "= 1.5.1"
}


provider "aws" {
  region = "eu-central-1"
}

provider "newrelic" {
  account_id = var.newrelic_account_id
  api_key    = var.newrelic_api_key
  region     = "EU"
}

module "main" {
  source               = "../modules"
  container_image      = var.container_image
  environment          = "dev"
  account_budget_limit = 1
  domain_name          = var.domain_name
  r53_zone_id          = var.r53_zone_id
  alarm_email          = var.alarm_email
  newrelic_account_id  = var.newrelic_account_id
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

variable "alarm_email" {
  type        = string
  description = "Email to which send alarm"
}

variable "newrelic_account_id" {
  type        = string
  description = "Newrelic accountId"
}

variable "newrelic_api_key" {
  type        = string
  description = "Newrelic api key"
}