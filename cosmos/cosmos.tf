provider "azurerm" {
  features {}
}

# Resource Group
data "azurerm_resource_group" "example" {
  name     = "example-resource-group232"
  #location = "East US"  # Update with your desired location
}

# Cosmos DB Account
resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = "my-cosmosdb-account"
  location            = "East US"
  resource_group_name = "example-resource-group232"
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
