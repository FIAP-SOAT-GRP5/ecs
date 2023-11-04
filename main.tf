locals {
  production_availability_zones = ["us-east-1a", "us-east-1b"]
}

provider "aws" {
  region = var.region
}

module "networking" {
  source               = "./modules/networking"
  vpc_cidr             = "10.0.0.0/16"
  public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidr = ["10.0.10.0/24", "10.0.20.0/24"]
  region               = var.region
  availability_zones   = local.production_availability_zones
}

module "ecs" {
  source              = "./modules/ecs"
  vpc_id              = module.networking.vpc_id
  availability_zones  = local.production_availability_zones
  repository_name     = "fiap-grp5"
  subnets_ids         = [for subnet in module.networking.private_subnets_id : subnet]
  public_subnet_ids   = [for subnet in module.networking.public_subnets_id : subnet]
  security_groups_ids = [for sg in module.networking.security_groups_ids : sg]
}
