## General Variables ###
variable "domain_name" {
  type        = string
  description = "The domain name"
}

variable "r53_zone_id" {
  type        = string
  description = "The zone ID of the domain"
}

variable "instance_type" {
  type        = string
  description = "Define the EC2 Instance type for the ecs cluster"
  default     = "t3.micro"
}

variable "container_image" {
  type        = string
  description = "Docker image for ECS task"
}

variable "app_name" {
  type        = string
  description = "Application name"
  default     = "pw-pusher"
}

variable "environment" {
  type        = string
  description = "Environment"
  default     = "dev"
}

variable "task_count" {
  type        = number
  description = "Number of running ECS tasks"
  default     = 1
}

variable "region" {
  type        = string
  description = "Region"
  default     = "eu-central-1"
}

variable "account_budget_limit" {
  type        = number
  description = "Budget limit for the whole account in USD per month"
  default     = 5
}

variable "budgets_per_service" {
  description = "List of AWS services to be monitored in terms of costs in USD per month"
  type        = map(object({ budget_limit = number }))
  default = {
    "Amazon Route 53" = {
      budget_limit = 0.5
    },
    "Amazon Elastic Compute Cloud - Compute" = {
      budget_limit = 0.1
    },
    "Amazon EC2 Container Service" = {
      budget_limit = 0.1
    },
    "AmazonCloudWatch" = {
      budget_limit = 0.1
    },
    "AmazonCloudWatch" = {
      budget_limit = 0.1
    },
    "Amazon Elastic Load Balancing" = {
      budget_limit = 0.1
    },
    "AWS Key Management Service" = {
      budget_limit = 0.1
    },
    "Amazon Simple Storage Service" = {
      budget_limit = 0.1
    }
  }
}

variable "alarm_email" {
  description = "Email to which send alarm"
  type        = string
}

variable "logs_retention_in_days" {
  description = "Retention period for logs in days"
  type        = number
  default     = 7
}