provider "azurerm" {
  subscription_id = var.subscription_id
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
}

resource "azurerm_resource_group" "main" {
  name = var.resource_group_name
  location = var.location
}

resource "azurerm_network_security_group" "default" {
  name = "default"
  location = var.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name = "allow_ssh"
    priority = 100
    direction = "inbound"
    protocol = "tcp"
    source_port_range = "*"
    target_port_range = "22"
    source_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "main" {
  name = "main"
  location = var.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name = "default"
    subnet_id = azurerm_subnet.default.id
    network_security_group_id = azurerm_network_security_group.default.id
  }
}

resource "azurerm_subnet" "default" {
  name = "default"
  resource_group_name = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefix = "10.0.0.0/24"
}

resource "azurerm_virtual_network" "main" {
  name = "main"
  location = var.location
  resource_group_name = azurerm_resource_group.main.name
  address_space = "10.0.0.0/16"
}

resource "azurerm_linux_virtual_machine" "main" {
  name = "main"
  location = var.location
  resource_group_name = azurerm_resource_group.main.name
  network_interface_ids = [azurerm_network_interface.main.id]
  size = "Standard_D2s_v3"
  admin_username = var.admin_username
  admin_password = var.admin_password
  image = "debian:11"
}

variable "479266ef-b2aa-4dc8-8c29-07d76744d6bc" {}
variable "d6dc57fd-b38b-4289-a7a5-3c758257795c" {}
variable "WtF8Q~-0amljSHR~VCudza~8BX1ViYlBjFx23dgt" {}
variable "798b4769-c7e2-489c-98b8-362ceda12432" {}
variable "My_Terraform_Practice" {}
variable "West US" {}
variable "admin" {}
variable "Admin@Password" {}