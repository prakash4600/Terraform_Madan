# main.tf

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "example" {
  name     = "example-resource-group232"
  #location = "East US"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-virtual-network1"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = "example-resource-group232"
}

resource "azurerm_subnet" "example" {
  name                 = "example-subnet1"
  resource_group_name  = "example-resource-group232"
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "example" {
  name                = "example-public-ip1"
  location            = "East US"
  resource_group_name = "example-resource-group232"
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic1"
  location            = "East US"
  resource_group_name = "example-resource-group232"

  ip_configuration {
    name                          = "example-ip-config"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}

resource "azurerm_virtual_machine" "example" {
  name                  = "example-vm1"
  location              = "East US"
  resource_group_name   = "example-resource-group232"
  network_interface_ids = [azurerm_network_interface.example.id]

  vm_size              = "Standard_DS1_v2"
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_profile {
    computer_name  = "examplevm"
    admin_username = "admin"
    admin_password = "Password@123"
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }

  storage_os_disk {
    name              = "example-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  tags = {
    environment = "dev"
  }
}
