provider "azurerm" {
  features {}
}


resource "azurerm_virtual_network" "vnet" {
  name                = "myvnetccp"
  resource_group_name = "My_Terraform_Practice"
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "default"
  resource_group_name  = "My_Terraform_Practice"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.0.0.0/24"
}

resource "azurerm_network_interface" "nic" {
  name                = "myniccpc"
  resource_group_name = "My_Terraform_Practice"
  location            = "East US"
  ip_configuration {
    name                          = "myipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "myccplinuxvm"
  location              = "East US" 
  resource_group_name   = "My_Terraform_Practice"
  network_interface_ids = [azurerm_network_interface.nic.id]

  size                 = "Standard_DS1_v2"  # Change this to your desired VM size
  delete_os_disk_on_termination = true

  admin_username       = "myadmin"  # Replace with your desired username
  admin_password       = "MyP@ssw0rd@4609"  # Replace with your desired password

  os_disk {
    name              = "osdisk"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.vm.name
}

output "vm_admin_username" {
  value = azurerm_linux_virtual_machine.vm.admin_username
}

output "vm_admin_password" {
  value = azurerm_linux_virtual_machine.vm.admin_password
}

output "vm_public_ip" {
  value = azurerm_network_interface.nic.private_ip_address
}
