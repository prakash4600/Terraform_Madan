# Define the Azure provider
provider "azurerm" {
  features {}
}

# Hub Resource Group
resource "azurerm_resource_group" "hub_rg" {
  name     = "hub-resource-group"
  location = "East US"
}

# Hub Virtual Network
resource "azurerm_virtual_network" "hub_vnet" {
  name                = "hub-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
}

# Hub Subnet
resource "azurerm_subnet" "hub_subnet" {
  name                 = "hub-subnet"
  resource_group_name  = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Application Gateway (Web Application Firewall)
resource "azurerm_application_gateway" "app_gateway" {
  name                = "web-application-gateway"
  resource_group_name = azurerm_resource_group.hub_rg.name
  location            = azurerm_resource_group.hub_rg.location

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "app_gateway_ip_configuration"
    subnet_id = azurerm_subnet.hub_subnet.id
  }

  # You can add frontend listeners, backend pools, rules, etc., for WAF configuration
  # ...

}

# Define the spoke environments (dev and QA)
variable "spoke_environments" {
  default = ["dev", "qa"]
}

# Spoke Resource Groups
locals {
  spoke_rgs = [for env in var.spoke_environments : "spoke-rg-${env}"]
}

resource "azurerm_resource_group" "spoke_rgs" {
  count = length(local.spoke_rgs)
  name  = local.spoke_rgs[count.index]
  location = "East US"
}

# Spoke Virtual Networks and Subnets
resource "azurerm_virtual_network" "spoke_vnets" {
  count               = length(local.spoke_rgs)
  name                = "spoke-vnet-${var.spoke_environments[count.index]}"
  address_space       = ["10.${count.index}.0.0/16"]
  location            = azurerm_resource_group.spoke_rgs[count.index].location
  resource_group_name = azurerm_resource_group.spoke_rgs[count.index].name
}

resource "azurerm_subnet" "spoke_subnets" {
  count                 = length(local.spoke_rgs)
  name                  = "spoke-subnet-${var.spoke_environments[count.index]}"
  resource_group_name   = azurerm_resource_group.spoke_rgs[count.index].name
  virtual_network_name  = azurerm_virtual_network.spoke_vnets[count.index].name
  address_prefixes      = ["10.${count.index}.0.0/24"]
}

# Create Windows VMs in Dev and QA environments
variable "vm_admin_username" {
  default = "adminuser"
}

variable "vm_admin_password" {
  default = "YourSuperSecretPassword!"
}

resource "azurerm_windows_virtual_machine" "vms" {
  count                 = length(local.spoke_rgs)
  name                  = "windows-vm-${var.spoke_environments[count.index]}"
  resource_group_name   = azurerm_resource_group.spoke_rgs[count.index].name
  location              = azurerm_resource_group.spoke_rgs[count.index].location
  size                  = "Standard_B1s"
  admin_username        = var.vm_admin_username
  admin_password        = var.vm_admin_password
  network_interface_ids = [azurerm_network_interface.vm_nics[count.index].id]

  os_disk {
    name              = "osdisk-${var.spoke_environments[count.index]}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

# Define network interfaces for VMs
resource "azurerm_network_interface" "vm_nics" {
  count               = length(local.spoke_rgs)
  name                = "vm-nic-${var.spoke_environments[count.index]}"
  location            = azurerm_resource_group.spoke_rgs[count.index].location
  resource_group_name = azurerm_resource_group.spoke_rgs[count.index].name

  ip_configuration {
    name                          = "ipconfig-${var.spoke_environments[count.index]}"
    subnet_id                     = azurerm_subnet.spoke_subnets[count.index].id
    private_ip_address_allocation = "Dynamic"
  }
}

# Output the URLs of the Windows VMs
output "vm_urls" {
  value = [for i in azurerm_windows_virtual_machine.vms : i.public_ip_address]
}

# Add additional configuration as needed
