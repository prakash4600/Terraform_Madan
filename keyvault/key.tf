provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources22"
  location = "West US"
}

resource "azurerm_key_vault" "example" {
  name                        = "example-keyvault22"
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name
  sku_name                    = "standard"   # Specify the SKU name (e.g., "standard", "premium")
  tenant_id                   = data.azurerm_client_config.current.tenant_id
}

data "azurerm_client_config" "current" {}

output "key_vault_id" {
  value = azurerm_key_vault.example.id
}

output "key_vault_uri" {
  value = azurerm_key_vault.example.vault_uri
}
