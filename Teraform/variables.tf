// variables.tf (root module)

// AWS & Azure providers
variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "azure_location" {
  description = "Azure location to deploy resources in"
  type        = string
  default     = "East US"
}

variable "azure_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "azure_client_id" {
  description = "Azure Client ID"
  type        = string
}

variable "azure_client_secret" {
  description = "Azure Client Secret"
  type        = string
  sensitive   = true
}

variable "azure_tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

// ECR module inputs
variable "ecr_repository_names" {
  description = "List of ECR repository names to create"
  type        = list(string)

  validation {
    condition     = length(var.ecr_repository_names) > 0
    error_message = "You must specify at least one ECR repository name."
  }
}

// ACR module inputs
variable "acr_name" {
  description = "Name of the Azure Container Registry (5–50 chars)"
  type        = string

  validation {
    condition     = length(var.acr_name) >= 5 && length(var.acr_name) <= 50
    error_message = "acr_name must be between 5 and 50 characters."
  }
}

variable "acr_resource_group" {
  description = "Azure resource group in which to create the ACR"
  type        = string

  validation {
    condition     = length(var.acr_resource_group) > 0
    error_message = "You must supply an acr_resource_group."
  }
}

variable "acr_sku" {
  description = "SKU for ACR (Basic, Standard, Premium)"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.acr_sku)
    error_message = "acr_sku must be one of: Basic, Standard, Premium."
  }
}
/*
// ECS module inputs
variable "ecs_cluster_name" {
  description = "Name for the ECS cluster"
  type        = string

  validation {
    condition     = length(var.ecs_cluster_name) > 0
    error_message = "You must supply an ecs_cluster_name."
  }
}

variable "fargate_asg_arn" {
  description = "ARN of the Auto Scaling Group for the FARGATE_SPOT capacity provider"
  type        = string

  validation {
    condition     = length(var.fargate_asg_arn) > 0
    error_message = "You must supply a fargate_asg_arn."
  }
}
*/

// Common tags
variable "common_tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
