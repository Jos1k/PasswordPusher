resource "aws_ecs_cluster" "cluster" {
  name = "ecs-${var.app_name}-api-${var.environment}"
}

resource "aws_ecs_task_definition" "task_definition" {
  container_definitions    = <<DEFINITION
[
    {
        "name": "${var.app_name}-api-${var.environment}",
        "image": "${var.container_image}", 
        "cpu": 256,
        "memory": 256,
        "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${var.app_name}-api-${var.environment}",
            "awslogs-create-group": "true",
            "awslogs-region": "${var.region}",
            "awslogs-stream-prefix": "ecs"
          }
        },
        "links": [],
        "portMappings": [
            { 
                "hostPort": 0,
                "containerPort": 80,
                "protocol": "tcp"
            }
        ],
        "essential": true,
        "entryPoint": [],
        "command": [],
        "environment": [],
        "mountPoints": [],
        "volumesFrom": []
    }
  ]
  DEFINITION
  family                   = "${var.app_name}-api-${var.environment}"
  network_mode             = "bridge"
  memory                   = "256"
  cpu                      = "256"
  requires_compatibilities = ["EC2"]
}

resource "aws_ecs_service" "service-webservice" {
  cluster         = aws_ecs_cluster.cluster.id
  desired_count   = var.task_count
  launch_type     = "EC2"
  name            = "${var.app_name}-api-service-${var.environment}"
  task_definition = aws_ecs_task_definition.task_definition.arn
  load_balancer {
    container_name   = "${var.app_name}-api-${var.environment}"
    container_port   = "80"
    target_group_arn = aws_alb_target_group.alb_public_webservice_target_group.arn
  }
}
