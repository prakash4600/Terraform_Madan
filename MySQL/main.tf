provider "azurerm" {
  features {}
}

#resource "azurerm_resource_group" "mysql" {
#  name     = "mymysqlresourcegroup"
#  location = "East US"  # Change this to your desired Azure region
#}

resource "azurerm_mysql_server" "mysql" {
  name                = "mymysqlserver"
  location            = azurerm_resource_group.mysql.location
  resource_group_name = azurerm_resource_group.mysql.name
  version             = "5.7"  # Choose the desired MySQL version

  administrator_login          = "myadmin"
  administrator_login_password = "MyP@ssw0rd!"  # Replace with your desired password
}

output "server_name" {
  value = azurerm_mysql_server.mysql.name
}

output "server_fqdn" {
  value = azurerm_mysql_server.mysql.fully_qualified_domain_name
}

output "server_username" {
  value = azurerm_mysql_server.mysql.administrator_login
}

output "server_password" {
  value = azurerm_mysql_server.mysql.administrator_login_password
}
