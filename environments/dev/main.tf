provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

module "vpc" {
  source       = "../../modules/vpc"
  cidr_block   = var.cidr_block
  aws_vpc_tags = var.vpc_tags
}

module "subnet_1" {
  source            = "../../modules/subnet"
  vpc_id            = module.vpc.vpc_id
  cidr_block_subnet = var.cidr_block_subnet_1
  availability_zone = var.availability_zone_1
  aws_subnet_tags   = var.aws_subnet_tags_1
}

module "subnet_2" {
  source            = "../../modules/subnet"
  vpc_id            = module.vpc.vpc_id
  cidr_block_subnet = var.cidr_block_subnet_2
  availability_zone = var.availability_zone_2
  aws_subnet_tags   = var.aws_subnet_tags_2
}

module "security_group" {
  source = "../../modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "iam" {
  source            = "../../modules/iam"
  aws_iam_role      = var.iam_role
  aws_iam_role_tags = var.iam_tags
}

module "ecr_repo" {
  source   = "../../modules/ecr_repository"
  ecr_name = var.ecr_name
}

module "ecs_task" {
  source       = "../../modules/ecs_task_definitions"
  family_name  = var.family_name
  aws_iam_role = module.iam.role_arn
  ecr_url      = module.ecr_repo.ecr_url
}

module "ecs_cluster" {
  source      = "../../modules/ecs_cluster"
  ecs_cluster = var.ecs_cluster
}

module "ecs_service" {
  source           = "../../modules/ecs_service"
  ecs_service_name = var.ecs_service_name
  cluster_id       = module.ecs_cluster.cluster_id
  task_definition  = module.ecs_task.arn_ecs_task
  subnet_1         = module.subnet_1.subnet_id
  subnet_2         = module.subnet_2.subnet_id
  security_group   = module.security_group.security_group_id
}
