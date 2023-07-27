provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "cosmosdb_rg" {
  name     = "my-cosmosdb-rg"
  location = "East US"  # Update with your desired location
}

# Cosmos DB Account
resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = "my-cosmosdb-account"
  location            = azurerm_resource_group.cosmosdb_rg.location
  resource_group_name = azurerm_resource_group.cosmosdb_rg.name
  offer_type          = "Standard"  # Change to desired offer type (e.g., "Standard", "Autoscale", "Serverless")
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level = "Session"  # Change to desired consistency level (e.g., "BoundedStaleness", "Eventual", etc.)
  }

  tags = {
    environment = "dev"
  }
}

output "cosmosdb_account_endpoint" {
  value = azurerm_cosmosdb_account.cosmosdb.document_endpoint
}
