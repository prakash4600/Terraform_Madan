provider "azurerm" {
  features {}
}

# Resource Group
data "azurerm_resource_group" "example" {
  name     = "example-resource-group232"
  #location = "East US"  # Update with your desired location
}

# Storage Account
resource "azurerm_storage_account" "storage_account" {
  name                     = "mystorageaccount232"  # Update with a unique name
  resource_group_name      = "example-resource-group232"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_storage_container" "container" {
  name                  = "mycontainer232"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"  # Change this to "blob" if you want public read access
}

output "storage_account_name" {
  value = azurerm_storage_account.storage_account.name
}

output "container_name" {
  value = azurerm_storage_container.container.name
}
