provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resource-group1222222222"
  location = "eastus"
}

resource "azurerm_key_vault" "example" {
  name                = "example-keyvault12334565"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.example.name
  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "get",
      "create",
      "delete",
      "list",
      "update",
      "import",
      "backup",
      "restore",
    ]

    secret_permissions = [
      "get",
      "list",
      "set",
      "delete",
      "backup",
      "restore",
    ]
  }

  
}

data "azurerm_client_config" "current" {}
