variable "cidr_block" {
  type = string
  default = "10.0.0.0/16"
  description = "Definicao do Range da VPC."
}

variable "vpc_tags" {
  type = map(string)
  default = {
    "name": "Rede para Kubernets"
    "author" : "Leandro"
  }
}

variable "cidr_block_subnet_1" {
  type = string
  description = "Range da Subnet 1"
  default = "10.0.1.0/24"
}

variable "cidr_block_subnet_2" {
  type = string
  description = "Range da Subnet 2"
  default = "10.0.2.0/24"
}

variable "availability_zone_1" {
  type = string
  description = "Regiao da Subnet 1"
  default = "us-east-1a"
}

variable "availability_zone_2" {
  type = string
  description = "Regiao da Subnet 2"
  default = "us-east-1b"
}

variable "aws_subnet_tags_1" {
  type = map(string)
  description = "Tags para Subnet 1."
  default = {
    "name" = "app_subnet_1"
  }
}

variable "aws_subnet_tags_2" {
  type = map(string)
  description = "Tags para Subnet 2."
  default = {
    "name" = "app_subnet_2"
  }
}

variable "iam_role" {
  type = string
  description = "Nome da role criada"
  default = "role_ecs"  
}

variable "iam_tags" {
  type = map(string)
  description = "Tags para a role criada"
  default = {
    "name" : "Role ECS"
    "author" : "Leandro"
  }
}

variable "ecr_name" {
  type = string
  description = "ECR Name"
  default = "app-repo"
}

variable "family_name" {
  type = string
  description = "Family Name"
  default = "app"
}

variable "ecs_cluster" {
  type = string
  description = "Cluster Name"
  default = "app_cluster"
}

variable "ecs_service_name" {
  type = string
  description = "Nome do servico ECS"
  default = "app-service"
}