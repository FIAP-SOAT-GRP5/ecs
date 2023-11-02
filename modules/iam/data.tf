data "aws_iam_policy_document" "this" {
  version = "2012-10-17"
  statement {
    sid     = "AllowExecutionFromECS"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
