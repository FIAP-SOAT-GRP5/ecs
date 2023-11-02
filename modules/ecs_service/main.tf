resource "aws_ecs_service" "this" {
  name            = var.ecs_service_name
  cluster         = var.cluster_id
  task_definition = var.task_definition
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [var.subnet_1, var.subnet_2]
    security_groups  = [var.security_group]
    assign_public_ip = true
  }
}
