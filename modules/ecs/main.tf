###################
# Cloudwatch Log Group
###################
resource "aws_cloudwatch_log_group" "app" {
  name = "app"

  tags = {
    Name = "FIAP"
  }
}

###################
# ECR repository to store our Docker images
###################
resource "aws_ecr_repository" "app" {
  name         = var.repository_name
  force_delete = true

  tags = {
    Name = "FIAP"
  }
}

###################
# ECS cluster
###################
resource "aws_ecs_cluster" "cluster" {
  name = "app_cluster"

  tags = {
    Name = "FIAP"
  }
}

###################
# ECS task definitions
###################
resource "aws_ecs_task_definition" "app" {
  family = "app"
  container_definitions = jsonencode([{
    name  = "app_container"
    image = "${aws_ecr_repository.app.repository_url}"
    portMappings = [{
      containerPort = 3000
      hostPort      = 3000
      protocol      = "tcp"
    }]
    essential = true
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "${aws_cloudwatch_log_group.app.name}"
        awslogs-region        = "us-east-1"
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_execution_role.arn

  tags = {
    Name = "FIAP"
  }
}

###################
# IAM service role
###################
data "aws_iam_policy_document" "ecs_service_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_role" {
  name               = "ecs_role"
  assume_role_policy = data.aws_iam_policy_document.ecs_service_role.json

  tags = {
    Name = "FIAP"
  }
}

data "aws_iam_policy_document" "ecs_service_policy" {
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "ec2:Describe*",
      "ec2:AuthorizeSecurityGroupIngress"
    ]
  }
}

resource "aws_iam_role_policy" "ecs_service_role_policy" {
  name   = "ecs_service_role_policy"
  policy = data.aws_iam_policy_document.ecs_service_policy.json
  role   = aws_iam_role.ecs_role.id
}

resource "aws_iam_role" "ecs_execution_role" {
  name               = "ecs_task_execution_role"
  assume_role_policy = file("${path.module}/policies/ecs-task-execution-role.json")

  tags = {
    Name = "FIAP"
  }
}
resource "aws_iam_role_policy" "ecs_execution_role_policy" {
  name   = "ecs_execution_role_policy"
  policy = file("${path.module}/policies/ecs-execution-role-policy.json")
  role   = aws_iam_role.ecs_execution_role.id
}

###################
# ECS service
###################
resource "aws_security_group" "ecs_service" {
  vpc_id      = var.vpc_id
  name        = "app-ecs-service-sg"
  description = "Allow egress from container"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "FIAP"
  }
}

data "aws_ecs_task_definition" "app" {
  task_definition = aws_ecs_task_definition.app.family
  depends_on      = [aws_ecs_task_definition.app]
}

resource "aws_ecs_service" "app" {
  name            = "app-service"
  task_definition = "${aws_ecs_task_definition.app.family}:${max("${aws_ecs_task_definition.app.revision}", "${data.aws_ecs_task_definition.app.revision}")}"
  desired_count   = 1
  launch_type     = "FARGATE"
  cluster         = aws_ecs_cluster.cluster.id
  depends_on      = [aws_iam_role_policy.ecs_service_role_policy]

  network_configuration {
    security_groups  = [for sg in flatten(concat(var.security_groups_ids, [aws_security_group.ecs_service.id])) : sg]
    subnets          = [for subnet in var.public_subnet_ids : subnet]
    assign_public_ip = true
  }

  tags = {
    Name = "FIAP"
  }
}
