/*---------------------------------------------------
 modules/ecr/variables.tf
---------------------------------------------------*/
variable "repository_names" {
  type        = list(string)
  description = "List of ECR repository names to create"
  validation {
    condition     = length(var.repository_names) > 0
    error_message = "At least one repository name must be provided."
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all ECR repositories"
  default     = {}
}
