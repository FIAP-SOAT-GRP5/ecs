resource "aws_ecr_repository" "this" {
  name                 = var.ecr_name
  force_delete         = true
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "fiap"
  }
}
