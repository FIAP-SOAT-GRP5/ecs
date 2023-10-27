variable "vpc_id" {
    type = string
    description = "ID da Rede VPC."
}

variable "cidr_block_subnet" {
    type = string
    description = "Range utilizado na Subnet."
}

variable "availability_zone" {
  type = string
  description = "Regiao da Subnet."
}

variable "aws_subnet_tags" {
    type = map(string)
    description = "Tags para a Subnet."
}

