terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5.0"
    }
  }
}


provider "aws" {
  region = "eu-central-1"
}

# ESC

resource "aws_ecs_cluster" "password_pusher_cluster" {
  name = "password-pusher"
}

# ESC API
resource "aws_ecs_task_definition" "password_pusher_api_task" {
  family                   = "password-pusher-api"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "password-pusher-api",
      "image": "ghcr.io/jos1k/passwordpusher-api:main",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ],
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"   
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = "${aws_iam_role.password_pusher_EcsTaskExecutionRole.arn}"
}

resource "aws_iam_role" "password_pusher_EcsTaskExecutionRole" {
  name               = "passwordPusherEcsTaskExecutionRole"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "password_pusher_ecsTaskExecutionRole_policy" {
  role       = "${aws_iam_role.password_pusher_EcsTaskExecutionRole.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_service" "password_pusher_api_service" {
  name            = "password-pusher-api-service"
  cluster         = "${aws_ecs_cluster.password_pusher_cluster.id}"
  task_definition = "${aws_ecs_task_definition.password_pusher_api_task.arn}"
  launch_type     = "FARGATE"
  desired_count   = 2

  load_balancer {
    target_group_arn = "${aws_lb_target_group.password_pusher_target_group.arn}" 
    container_name   = "${aws_ecs_task_definition.password_pusher_api_task.family}"
    container_port   = 80
  }

  network_configuration {
    subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}"]
    assign_public_ip = true
    security_groups = ["${aws_security_group.password_pusher_ecs_service_security_group.id}"]
  }
}


# NETWORK
resource "aws_default_vpc" "default_vpc" {
}

resource "aws_default_subnet" "default_subnet_a" {
  availability_zone = "eu-central-1a"
}

resource "aws_default_subnet" "default_subnet_b" {
  availability_zone = "eu-central-1b"
}

resource "aws_alb" "password_pusher_application_load_balancer" {
  name               = "password-pusher-lb"
  load_balancer_type = "application"
  subnets = [
    "${aws_default_subnet.default_subnet_a.id}",
    "${aws_default_subnet.default_subnet_b.id}"
  ]

  security_groups = ["${aws_security_group.password_pusher_load_balancer_security_group.id}"]
}

resource "aws_lb_target_group" "password_pusher_target_group" {
  name        = "password-pusher-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "${aws_default_vpc.default_vpc.id}"
  health_check {
    matcher = "200,301,302"
    path = "/WeatherForecast"
  }
}

resource "aws_lb_listener" "assword_pusher_listener" {
  load_balancer_arn = "${aws_alb.password_pusher_application_load_balancer.arn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.password_pusher_target_group.arn}"
  }
}


resource "aws_security_group" "password_pusher_load_balancer_security_group" {
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0 
    to_port     = 0 
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "password_pusher_ecs_service_security_group" {
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    security_groups = ["${aws_security_group.password_pusher_load_balancer_security_group.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}