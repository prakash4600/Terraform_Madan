provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "cosmosdb" {
  name     = "My_Terraform_Practice"
  location = "East US"  # Change this to your desired Azure region
}

resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = "ccpcosmosdb"
  resource_group_name = azurerm_resource_group.cosmosdb.name
  location            = azurerm_resource_group.cosmosdb.location
  offer_type          = "Standard"
  kind                = "MongoDB"  # This specifies the NoSQL API as MongoDB
}

output "endpoint" {
  value = azurerm_cosmosdb_account.cosmosdb.endpoint
}

output "primary_master_key" {
  value = azurerm_cosmosdb_account.cosmosdb.primary_master_key
}
