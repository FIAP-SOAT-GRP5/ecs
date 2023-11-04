output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnets_id" {
  value = [for subnet in aws_subnet.public_subnet.*.id : subnet]
}

output "private_subnets_id" {
  value = [for subnet in aws_subnet.private_subnet.*.id : subnet]
}

output "default_sg_id" {
  value = aws_security_group.default.id
}

output "security_groups_ids" {
  value = ["${aws_security_group.default.id}"]
}

