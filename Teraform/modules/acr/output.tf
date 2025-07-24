/*---------------------------------------------------
 modules/acr/outputs.tf
---------------------------------------------------*/
output "login_server" {
  description = "The login server URL for the ACR"
  value       = azurerm_container_registry.this.login_server
}
output "acr_id" {
  description = "The resource ID of the ACR"
  value       = azurerm_container_registry.this.id
}
