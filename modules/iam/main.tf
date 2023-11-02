# resource "aws_iam_policy" "policy" {
#   name   = "policy_ecs"
#   policy = data.aws_iam_policy_document.this.json

# }

resource "aws_iam_role" "aws_role" {
  name               = var.aws_iam_role
  description        = "Role de Servico do ECS."
  assume_role_policy = data.aws_iam_policy_document.this.json
  tags               = var.aws_iam_role_tags
}

resource "aws_iam_policy_attachment" "attachment" {
  depends_on = [aws_iam_role.aws_role]
  name       = "policy_attachment_ecs"
  roles      = [aws_iam_role.aws_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "aws" {
  role       = aws_iam_role.aws_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}