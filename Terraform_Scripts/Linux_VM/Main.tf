
# Resource group
resource "azurerm_resource_group" "example" {
  name     = "my"
  location = "East US"
}

# Virtual network
resource "azurerm_virtual_network" "example" {
  name                = "my-virtual-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Subnet
resource "azurerm_subnet" "example" {
  name                 = "my-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Network security group
resource "azurerm_network_security_group" "example" {
  name                = "my-network-security-group"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Network interface
resource "azurerm_network_interface" "example" {
  name                      = "my-network-interface"
  location                  = azurerm_resource_group.example.location
  resource_group_name       = azurerm_resource_group.example.name


  ip_configuration {
    name                          = "my-ip-configuration"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Virtual machine
resource "azurerm_virtual_machine" "example" {
  name                  = "my-virtual-machine"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.example.id]
  vm_size               = "Standard_DS2_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "my-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "my-vm"
    admin_username = "adoption"
    admin_password = "Cloudcentral@460"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}