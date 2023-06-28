resource "aws_instance" "ec2_instance" {
  ami                    = "ami-07480655a02fc53ae" #Amazon ECS-Optimized Amazon Linux 2 x86_64 AMI
  subnet_id              = module.vpc.private_subnets[0]
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_instance_profile.ecs_agent.name
  vpc_security_group_ids = [aws_security_group.ec2_ecs_instance.id]
  ebs_optimized          = "false"
  source_dest_check      = "false"
  tags                   = {
    Name = "${var.app_name}-api-${var.environment}"
  }
  user_data              = <<EOF
    #!/bin/bash

    # sudo amazon-linux-extras install -y ecs;

    sudo amazon-linux-extras disable docker
    sudo systemctl disable ecs
    echo ECS_CLUSTER=ecs-${var.app_name}-api-${var.environment} >> /etc/ecs/ecs.config

    # cat /etc/ecs/ecs.config | grep "ECS_CLUSTER"
    sudo systemctl enable --now ecs
  EOF

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "30"
    delete_on_termination = "true"
    tags = {
      Name = "${var.app_name}-api-${var.environment}"
    }
  }
}