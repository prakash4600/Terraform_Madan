provider "azurerm" {
  features {}
}

resource "azurerm_storage_account" "storage" {
  name                     = "cccpstorageaccount345"
  resource_group_name      = "My_Terraform_Practice"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "mycontainer"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"  # Change this to "blob" if you want public read access
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "container_name" {
  value = azurerm_storage_container.container.name
}
