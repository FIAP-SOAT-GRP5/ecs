variable "vpc_id" {
}

variable "availability_zones" {
  type = list(string)
}

variable "security_groups_ids" {
  type = list(string)
}

variable "subnets_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "repository_name" {
  type = string
}
