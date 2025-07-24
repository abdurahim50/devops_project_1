/*---------------------------------------------------
 versions.tf
---------------------------------------------------*/
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}

/*---------------------------------------------------
 backend.tf (Azure backend example)
---------------------------------------------------*/
// Uncomment for Azure Storage remote state
// terraform {
//   backend "azurerm" {
//     resource_group_name  = var.azurerm_state_rg
//     storage_account_name = var.azurerm_state_sa
//     container_name       = var.azurerm_state_container
//     key                  = "terraform.tfstate"
//   }
// }
