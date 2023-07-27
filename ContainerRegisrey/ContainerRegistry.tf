provider "azurerm" {
  features {}
}


resource "azurerm_container_registry" "registry" {
  name                = "mycontaier345nerregistry"
  location            = "East US"
  resource_group_name = "My_Terraform_Practice"
  sku                 = "Standard"  # Change this to your desired SKU (Basic, Standard, Premium)

  admin_enabled = false  # Change this to true if you want admin user enabled

  tags = {
    environment = "dev"
  }
}

output "registry_name" {
  value = azurerm_container_registry.registry.name
}

output "registry_login_server" {
  value = azurerm_container_registry.registry.login_server
}
