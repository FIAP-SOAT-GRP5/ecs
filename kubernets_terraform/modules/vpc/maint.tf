resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  tags       = var.aws_vpc_tags
}