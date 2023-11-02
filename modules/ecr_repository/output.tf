output "ecr_url" {
  description = "AWS ECR Repository URL"
  value       = aws_ecr_repository.this.repository_url
}
