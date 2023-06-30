output "resource_group_id" {
  description = "ID of the resource group"
  value       = azurerm_resource_group.ccp.id
}

output "dns_zone_id" {
  description = "ID of the DNS zone"
  value       = azurerm_dns_zone.ccp.id
}

output "cdn_profile_id" {
  description = "ID of the CDN front door profile"
  value       = azurerm_cdn_frontdoor_profile.ccp.id
}

output "cdn_custom_domain_id" {
  description = "ID of the CDN custom domain"
  value       = azurerm_cdn_frontdoor_custom_domain.ccp.id
}

output "mysql_server_id" {
  description = "ID of the MySQL server"
  value       = azurerm_mysql_server.ccp.id
}

output "service_plan_id" {
  description = "ID of the app service plan"
  value       = azurerm_service_plan.ccp.id
}

output "web_app_id" {
  description = "ID of the web app"
  value       = azurerm_windows_web_app.ccp.id
}

output "storage_account_id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.ccp.id
}

output "storage_container_id" {
  description = "ID of the storage container"
  value       = azurerm_storage_container.ccp.id
}

output "container_registry_id" {
  description = "ID of the container registry"
  value       = azurerm_container_registry.acr.id
}

output "log_analytics_workspace_id" {
  description = "ID of the log analytics workspace"
  value       = azurerm_log_analytics_workspace.ccp.id
}

output "container_app_environment_id" {
  description = "ID of the container app environment"
  value       = azurerm_container_app_environment.ccp.id
}

output "container_app_id" {
  description = "ID of the container app"
  value       = azurerm_container_app.ccp.id
}

output "key_vault_id" {
  description = "ID of the key vault"
  value       = azurerm_key_vault.ccp.id
}