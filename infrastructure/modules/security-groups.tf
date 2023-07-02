resource "aws_security_group" "public" {
  name        = "Allow public HTTP/HTTPS ALB"
  description = "Public internet access"
  vpc_id      = module.vpc.vpc_id
  tags                   = {
    Name = "${var.app_name}-${var.environment}-public-sg"
  }
}

resource "aws_security_group_rule" "public_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "public_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "public_in_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}




resource "aws_security_group" "ec2" {
  name        = "Allow traffic from ALB"
  description = "Allow traffic from ALB"
  vpc_id      = module.vpc.vpc_id
  tags                   = {
    Name = "${var.app_name}-${var.environment}-ec2-sg"
  }
}

resource "aws_security_group_rule" "ec2_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.ec2.id
}

resource "aws_security_group_rule" "ec2_in_http" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id = aws_security_group.public.id
  security_group_id = aws_security_group.ec2.id
}