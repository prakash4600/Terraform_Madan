provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "Micorsoft_Bing"
  location = "West Europe"
}

resource "azurerm_virtual_network" "example" {
  name                = "bing-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "bing-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "example" {
  name                = "bing-publicip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_security_group" "example" {
  name                = "bing-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "example" {
  name                = "bing-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }

  depends_on = [
    azurerm_network_security_group.example,
  ]
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "bing-machine460"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  network_interface_ids       = [azurerm_network_interface.example.id]
  size                        = "Standard_DS1_v2"
  
   os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
   }

   source_image_reference {
     publisher         ="Canonical"
     offer             ="UbuntuServer"
     sku               ="18.04-LTS"
     version           ="latest"
   }

   admin_username             ="azureuser"
   admin_password             ="Password@46000"
}
