resource "aws_subnet" "this" {
  vpc_id = var.vpc_id
  cidr_block = var.cidr_block_subnet
  availability_zone = var.availability_zone
  tags = var.aws_subnet_tags
}