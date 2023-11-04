variable "vpc_cidr" {
}

variable "public_subnets_cidr" {
  type = list(string)
}

variable "private_subnets_cidr" {
  type = list(string)
}

variable "region" {
  type = string
}

variable "availability_zones" {
  type = list(any)
}
