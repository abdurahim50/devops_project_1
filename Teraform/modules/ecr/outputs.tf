/*---------------------------------------------------
 modules/ecr/outputs.tf
---------------------------------------------------*/
output "repository_arns" {
  description = "ARNs of the created ECR repositories"
  value       = values(aws_ecr_repository.this)[*].arn
}
