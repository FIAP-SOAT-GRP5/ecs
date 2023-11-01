resource "aws_iam_role" "aws_role" {
  name = var.aws_iam_role
  description = "Role de Servico do ECS."
  assume_role_policy = data.aws_iam_policy_document.this.json
  tags = var.aws_iam_role_tags 
}

resource "aws_iam_policy_attachment" "attachment" {
  depends_on = [ aws_iam_role.aws_role ]
  name       = "policy_attachment_ecs"
  roles	     = [aws_iam_role.aws_role]
  policy_arn = data.aws_iam_policy_document.this.arn
}

