```
# Define provider for Azure
provider "azurerm" {
  features {}
}

# Create resource group
resource "azurerm_resource_group" "example" {
  name     = "sample_rg"
  location = "East US"
}

# Create virtual network
resource "azurerm_virtual_network" "example" {
  name                = "my-vnet"
  address_space       = ["192.168.0.0/24"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Create subnet
resource "azurerm_subnet" "example" {
  name                 = "my-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["192.168.0.0/24"]
}

# Create network security group
resource "azurerm_network_security_group" "example" {
  name                = "my-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "allow-http"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-https"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "dev"
  }
}

# Create public IP for front door
resource "azurerm_public_ip" "example" {
  name                = "my-public-ip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
}

# Create front door
resource "azurerm_frontdoor" "example" {
  name                      = "my-frontdoor"
  resource_group_name       = azurerm_resource_group.example.name
  location                  = azurerm_resource_group.example.location
  friendly_name             = "My Front Door"
  frontend_endpoints         = ["${azurerm_public_ip.example.ip_address}"]
  backend_pools              = ["${azurerm_lb_backend_pool.example.id}"]
  routing_rule              = ["${azurerm_frontdoor_custom_http_configuration.example.id}"]
  
  frontend_endpoint_routing {
    name                           = "my-frontend-endpoint-routing"
    protocol                       = "Http"
    frontend_endpoints             = ["${azurerm_public_ip.example.id}"]
    custom_https_configuration_id  = "${azurerm_frontdoor_custom_https_configuration.example.id}"
  }

  tags = {
    environment = "dev"
  }
}

# Create backend pool for middle ware VM
resource "azurerm_lb_backend_pool" "example" {
  name                = "my-backend-pool"
  resource_group_name = azurerm_resource_group.example.name
  loadbalancer_id     = azurerm_lb_balancer.example.id
}

# Create load balancer for middle ware VM
resource "azurerm_lb_balancer" "example" {
  name                = "my-load-balancer"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  frontend_ip_configuration {
    name                 = "lb-public-ip"
    public_ip_address_id = azurerm_public_ip.example.id
  }

  tags = {
    environment = "dev"
  }
}

# Create VM for middle ware
resource "azurerm_virtual_machine" "example" {
  name                = "my-middleware-vm"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  network_interface_ids = [
    azurerm_network_interface.example.id
  ]
  vm_size = "Standard_D2_v3"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = {
    environment = "dev"
  }
}

# Create network interface for middle ware VM
resource "azurerm_network_interface" "example" {
  name                = "my-network-interface"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  ip_configuration {
    name                          = "my-ip-configuration"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.example.id
  }

  tags = {
    environment = "dev"
  }
}

# Create backend pool for web app VM
resource "azurerm_lb_backend_pool" "example" {
  name                = "my-webapp-backend-pool"
  resource_group_name = azurerm_resource_group.example.name
  loadbalancer_id     = azurerm_lb_balancer.example.id
}

# Create load balancer for web app VM
resource "azurerm_lb_balancer" "example" {
  name                = "my-webapp-load-balancer"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  frontend_ip_configuration {
    name                 = "webapp-lb-public-ip"
    public_ip_address_id = azurerm_public_ip.example.id
  }

  tags = {
    environment = "dev"
  }
}

# Create VM for web app
resource "azurerm_virtual_machine" "example" {
  name                = "my-webapp-vm"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  network_interface_ids = [
    azurerm_network_interface.example.id
  ]
  vm_size = "Standard_D2_v3"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = {
    environment = "dev"
  }
}

# Create custom HTTP configuration
resource "azurerm_frontdoor_custom_http_configuration" "example" {
  name                 = "my-http-configuration"
  resource_group_name  = azurerm_resource_group.example.name
  location             = azurerm_resource_group.example.location
  host_name             = "www.example.com"
  
  tags = {
    environment = "dev"
  }
}

# Create custom HTTPS configuration
resource "azurerm_frontdoor_custom_https_configuration" "example" {
  name                 = "my-https-configuration"
  resource_group_name  = azurerm_resource_group.example.name
  location             = azurerm_resource_group.example.location
  host_name             = "www.example.com"
  key_vault_certificate {
    id   = "<KEY_VAULT_CERTIFICATE_ID>"
    name = "<KEY_VAULT_CERTIFICATE_NAME>"
  }
  
  tags = {
    environment = "dev"
  }
}

# Create MySQL database server
resource "azurerm_mysql_server" "example" {
  name                = "my-mysql-server"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "B_Gen5_1"
  storage_mb          = 5120
  administrator_login          = "myadmin"
  administrator_login_password = "P@ssw0rd123!"
  version             = "5.7"

  tags = {
    environment = "dev"
  }
}

# Create MySQL database
resource "azurerm_mysql_database" "example" {
  name                = "my-database"
  server_name         = azurerm_mysql_server.example.name
  resource_group_name = azurerm_resource_group.example.name
  charset             = "utf8"

  tags = {
    environment = "dev"
  }
}
```

Note: Replace `<KEY_VAULT_CERTIFICATE_ID>` and `<KEY_VAULT_CERTIFICATE_NAME>` in the `azurerm_frontdoor_custom_https_configuration` resource with your own Key Vault certificate values.