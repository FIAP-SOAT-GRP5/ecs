resource "aws_ecs_task_definition" "this" {
  family = var.family_name
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn = var.aws_iam_role

  container_definitions = jsonencode([{
    name = "app_container"
    image = "${var.ecr_url}:latest"
    portMappings = [{
        containerPort = 3000
        hostPort = 3000
    }]
    essential = true
  }])
  memory = 512
  cpu = 256
}

