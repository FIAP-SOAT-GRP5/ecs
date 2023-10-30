variable "ecs_service_name" {
  type = string
  description = "Nome do servico ECS"
}

variable "cluster_id" {
  type = string
  description = "id do cluster"
}

variable "task_definition" {
  type = string
  description = "Arn da Task"
}

variable "subnet_1" {
  type = string
  description = "ID da Subnet 1"
}

variable "subnet_2" {
  type = string
  description = "ID da Subnet 2"
}

variable "security_group" {
  type = string
  description = "ID do grupo de seguranca"
}
