/*---------------------------------------------------
 modules/ecr/main.tf
---------------------------------------------------*/
// Creates one or more AWS ECR repositories
resource "aws_ecr_repository" "this" {
  for_each = toset(var.repository_names)
  name     = each.value
  tags     = var.tags
  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "AES256"
  }
}