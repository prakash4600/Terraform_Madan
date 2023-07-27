provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "storage_rg" {
  name     = "my-storage-account-rg"
  location = "East US"  # Update with your desired location
}

# Storage Account
resource "azurerm_storage_account" "storage_account" {
  name                     = "mystorageaccount"  # Update with a unique name
  resource_group_name      = azurerm_resource_group.storage_rg.name
  location                 = azurerm_resource_group.storage_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
  }
}

# Storage Container
resource "azurerm_storage_container" "storage_container" {
  name                  = "mycontainer"  # Update with a unique name for the container
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"  # Change to "blob" if you want the container to be publicly accessible

  depends_on = [azurerm_storage_account.storage_account]
}

output "storage_account_name" {
  value = azurerm_storage_account.storage_account.name
}

output "storage_account_primary_key" {
  value     = azurerm_storage_account.storage_account.primary_access_key
  sensitive = true
}

output "storage_container_name" {
  value = azurerm_storage_container.storage_container.name
}
