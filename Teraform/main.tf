/*---------------------------------------------------
 main.tf (Root)
---------------------------------------------------*/
provider "aws" {
  region = var.aws_region
}

provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
}

module "ecr" {
  source          = "./modules/ecr"
  repository_names = var.ecr_repository_names
  tags            = var.common_tags
}

module "acr" {
  source              = "./modules/acr"
  acr_name            = var.acr_name
  resource_group_name = var.acr_resource_group
  location            = var.azure_location
  sku                 = var.acr_sku
  tags                = var.common_tags
}

/*module "ecs" {
  source          = "./modules/ecs"
  cluster_name    = var.ecs_cluster_name
  fargate_asg_arn = var.fargate_asg_arn
  tags            = var.common_tags
}
*/

