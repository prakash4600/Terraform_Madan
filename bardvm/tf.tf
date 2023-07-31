provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West US"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-vm"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  size         = "Standard_B1s"
  admin_username     = "zxcvbn"
  admin_password     = "P@ssw0rd!!"
  
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = "30"
    create_option        = "FromImage"
    name                 = "${azurerm_linux_virtual_machine.example.name}-osdisk"
  }

source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
}
}

resource "azurerm_storage_account" "example" {
  name                     = "mnbvcxz"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [azurerm_subnet.example.id]
}


resource "azurerm_storage_container" "example" {
name                  ="weeeeee"
storage_account_name   ="${azurerm_storage_account.example.name}"
container_access_type ="private"

depends_on=[
azurerm_storage_account.example,
]

}

resource "azurerm_container_registry" "example" {
name                     ="qazwsx"
resource_group_name      ="${azurerm_resource_group.example.name}"
location                 ="${azurerm_resource_group.example.location}"
admin_enabled            ="true"

network_rule_set{
default_action="Deny"

virtual_network_subnet_ids=[
"${azurerm_subnet.example.id}"
]
}
}
