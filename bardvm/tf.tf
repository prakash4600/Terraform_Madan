provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name = "my-resource-group467"
  location = "westus"
}

resource "azurerm_network_security_group" "example" {
  name = "my-network-security-group"
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name = "allow-rdp"
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "3389"
    source_address_prefix = "*"
    priority = 100
  }

  security_rule {
    name = "allow-http"
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "80"
    source_address_prefix = "*"
    priority = 110
  }
}


resource "azurerm_network_interface" "example" {
  name = "my-network-interface"
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name = "my-ip-configuration"
    subnet_id = azurerm_subnet.example.id
    private_ip_address = "10.0.0.10"
    private_ip_allocation_method = "Static"
  }

  network_security_group_id = azurerm_network_security_group.example.id
}

resource "azurerm_virtual_machine" "example" {
  name = "my-virtual-machine"
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  vm_size = "Standard_D2s_v3"

  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  storage_image_reference {
     publisher = "MicrosoftWindowsServer"
     offer = "WindowsServer"
     sku = "2019-Datacenter"
     version = "latest"
  }

  os_profile {
    computer_name = "my-virtual-machine4567"
    admin_username = "admin"
    admin_password = "Pa$$w0rd!"
  }
}
