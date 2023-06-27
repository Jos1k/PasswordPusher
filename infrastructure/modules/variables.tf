## General Variables ###
variable "domain_name" {
  type        = string
  description = "The domain name"
  default     = "pw-pusher.click"
}

variable "r53_zone_id" {
  type        = string
  description = "The zone ID of the domain"
  default     = "Z0718599212MVN64WNQI1"
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
  type = string
  description = "Application name"
  default = "pw-pusher"
}

variable "environment" {
  type = string
  description = "Environment"
  default = "dev"
}

variable "task_count" {
  type = number
  description = "Number of running ECS tasks"
  default = 1
}

variable "region" {
  type = string
  description = "Region"
  default = "eu-central-1"
}