/*---------------------------------------------------
 modules/acr/main.tf
---------------------------------------------------*/
resource "azurerm_resource_group" "acr_rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_container_registry" "this" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.acr_rg.name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = false
  tags                = var.tags
}
