resource "aws_iam_role" "aws_role" {
  name = var.aws_iam_role
  description = "Role de Servico do ECS."
  assume_role_policy = data.aws_iam_policy_document.this.json
  tags = var.aws_iam_role_tags 
}

resource "aws_iam_policy_attachment" "attachment" {
  depends_on = [ aws_iam_role.aws_role ]
  name       = join("", aws_iam_role.aws_role.*.name)
  policy_arn = join("", data.aws_iam_policy_document.this.*.arn)
}

