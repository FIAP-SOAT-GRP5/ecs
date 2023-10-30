variable "aws_iam_role" {
  type = string
  description = "Nome da Role utilizada"
}

variable "aws_iam_role_tags" {
  type = map(string)
  description = "Tags utilizadas na Role"
}
