data "aws_iam_policy_document" "this" {
    statement {
      effect = "Allow"

        principals {
          type = "Service"
          identifiers = ["ecs-tasks.amazonaws.com"]  
        }

        actions = ["sts:AssumeRole"]
    }
}