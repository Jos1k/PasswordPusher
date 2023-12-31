module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2"

  name = "${var.app_name}-${var.environment}"
  cidr = "10.99.0.0/18"

  azs            = ["${var.region}a", "${var.region}b"]
  public_subnets = ["10.99.0.0/24", "10.99.1.0/24"]
  # private_subnets  = ["10.99.3.0/24", "10.99.4.0/24"]
  # database_subnets = ["10.99.7.0/24", "10.99.8.0/24"]

  create_database_subnet_group = false
  enable_dns_hostnames         = true

  enable_nat_gateway = false

  tags = {
    Name = "${var.app_name}-api-${var.environment}"
  }
}
