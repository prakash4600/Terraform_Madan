resource "azurerm_resource_group" "ccp" {
  name     = "bhanu"
  location = "eastus"

  tags = {
    env     = "qa"
    project = "ccp"
  }
}
