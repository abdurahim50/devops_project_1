/*---------------------------------------------------
 modules/acr/variables.tf
---------------------------------------------------*/
variable "acr_name" {
  type        = string
  description = "Name of the Azure Container Registry"
  validation {
    condition     = length(var.acr_name) >= 5 && length(var.acr_name) <= 50
    error_message = "ACR name must be between 5 and 50 characters."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Azure resource group name for ACR"
}

variable "location" {
  type        = string
  description = "Azure region for ACR"
}

variable "sku" {
  type        = string
  description = "SKU for ACR (Basic, Standard, Premium)"
  default     = "Standard"
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "SKU must be Basic, Standard, or Premium."
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to ACR and resource group"
  default     = {}
}