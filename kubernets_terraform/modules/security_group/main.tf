resource "aws_security_group" "this" {
    name_prefix = "app_sg_"
    vpc_id = var.vpc_id
    ingress {
        from_port = 3000
        to_port = 3000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}