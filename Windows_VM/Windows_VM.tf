provider "azurerm" {
  features {}
}
resource "azurerm_virtual_network" "vnet" {
  name                = "myvnet"
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
  name                = "mynic"
  resource_group_name = "My_Terraform_Practice"
  location            = "East US"

  ip_configuration {
    name                          = "myipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "ccpvm460"
  location              = "East US"
  resource_group_name   = "My_Terraform_Practice"
  network_interface_ids = [azurerm_network_interface.nic.id]

  vm_size              = "Standard_DS1_v2"  # Change this to your desired VM size
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"  # Change this to your desired Windows Server version
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "myvm"
    admin_username = "myadmin"
    admin_password = "MyP@ssw0rd@460"  # Replace with your desired password
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }
}

output "vm_name" {
  value = azurerm_virtual_machine.vm.name
}

output "vm_admin_username" {
  value = azurerm_virtual_machine.vm.os_profile[0].admin_username
}

output "vm_admin_password" {
  value = azurerm_virtual_machine.vm.os_profile[0].admin_password
}

output "vm_public_ip" {
  value = azurerm_network_interface.nic.private_ip_address
}
