provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources234"
  location = "East US"
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = "example-log-analytics"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
}

output "workspace_id" {
  value = azurerm_log_analytics_workspace.example.workspace_id
}
