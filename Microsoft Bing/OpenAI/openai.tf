# Define provider and resource block  
provider "azurerm" {  
  features {}  
}  
  
resource "azurerm_resource_group" "example" {  
  name     = "exampl7324e-resource-group"  
  location = "eastus"  
}  
  
resource "azurerm_virtual_network" "example" {  
  name                = "exampl23re-vnet"  
  address_space       = ["10.0.0.0/16"]  
  location            = azurerm_resource_group.example.location  
  resource_group_name = azurerm_resource_group.example.name  
}  
  
resource "azurerm_subnet" "example" {  
  name                 = "examr23r2ple-subnet"  
  resource_group_name  = azurerm_resource_group.example.name  
  virtual_network_name = azurerm_virtual_network.example.name  
  address_prefixes     = ["10.0.1.0/24"]  
}  
  
resource "azurerm_public_ip" "example" {  
  name                = "examplr232re-public-ip"  
  location            = azurerm_resource_group.example.location  
  resource_group_name = azurerm_resource_group.example.name  
  allocation_method   = "Static"  
}  
  
resource "azurerm_network_interface" "example" {  
  name                      = "exampl2r3re-nic"  
  location                  = azurerm_resource_group.example.location  
  resource_group_name       = azurerm_resource_group.example.name  
  network_security_group_id = azurerm_network_security_group.example.id  
  
  ip_configuration {  
    name                          = "exa2rmple-ipconfig"  
    subnet_id                     = azurerm_subnet.example.id  
    private_ip_address_allocation = "Dynamic"  
    public_ip_address_id          = azurerm_public_ip.example.id  
  }  
}  
  
resource "azurerm_network_security_group" "example" {  
  name                = "example23rr-nsg"  
  location            = azurerm_resource_group.example.location  
  resource_group_name = azurerm_resource_group.example.name  
}  
  
resource "azurerm_network_security_rule" "example" {  
  name                        = "example-allow-ssh"  
  priority                    = 1001  
  direction                   = "Inbound"  
  access                      = "Allow"  
  protocol                    = "Tcp"  
  source_port_range            = "*"  
  destination_port_range       = "22"  
  source_address_prefix        = "*"  
  destination_address_prefix   = "*"  
  resource_group_name         = azurerm_resource_group.example.name  
  network_security_group_name = azurerm_network_security_group.example.name  
}  
  
resource "azurerm_virtual_machine" "example" {  
  name                  = "exam23r2rple-vm"  
  location              = azurerm_resource_group.example.location  
  resource_group_name   = azurerm_resource_group.example.name  
  network_interface_ids = [azurerm_network_interface.example.id]  
  vm_size               = "Standard_DS1_v2"  
  
  storage_image_reference {  
    publisher = "Canonical"  
    offer     = "UbuntuServer"  
    sku       = "18.04-LTS"  
    version   = "latest"  
  }  
  
  storage_os_disk {  
    name              = "example-osdisk"  
    caching           = "ReadWrite"  
    create_option     = "FromImage"  
    managed_disk_type = "Standard_LRS"  
  }  
  
  os_profile {  
    computer_name  = "exam23r2rple-vm"  
    admin_username = "adminuser"  
    admin_password = "P@ssw0rd1234"  
  }  
  
  os_profile_linux_config {  
    disable_password_authentication = false  
  }  
  
  tags = {  
    environment = "dev"  
  }  
}  
