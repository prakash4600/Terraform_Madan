provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources22"
  location = "West US"
}

resource "azurerm_key_vault" "example" {
  name                        = "example-keyvault"
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name
  enabled_for_disk_encryption = true
  enabled_for_deployments     = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
}

data "azurerm_client_config" "current" {}

output "key_vault_id" {
  value = azurerm_key_vault.example.id
}

output "key_vault_uri" {
  value = azurerm_key_vault.example.vault_uri
}
