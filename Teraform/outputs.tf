/*---------------------------------------------------
 outputs.tf (Root)
---------------------------------------------------*/
output "ecr_repository_arns" {
  description = "List of created ECR repository ARNs"
  value       = module.ecr.repository_arns
}
output "acr_login_server" {
  description = "Login server URL for ACR"
  value       = module.acr.login_server
}
/*
output "ecs_cluster_arn" {
  description = "ARN of the created ECS cluster"
  value       = module.ecs.cluster_arn
}
*/