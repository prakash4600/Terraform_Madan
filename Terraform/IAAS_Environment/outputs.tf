output "resource_group_name" {
  value = azurerm_resource_group.example.name
}

output "virtual_network_name" {
  value = azurerm_virtual_network.example.name
}

output "subnet_name" {
  value = azurerm_subnet.example.name
}

output "frontdoor_profile_name" {
  value = azurerm_cdn_frontdoor_profile.example.name
}

output "frontdoor_endpoint_name" {
  value = azurerm_cdn_frontdoor_endpoint.example.name
}

output "virtual_machine1_name" {
  value = azurerm_virtual_machine.example1.name
}

output "virtual_machine2_name" {
  value = azurerm_virtual_machine.example2.name
}

output "network_interface1_name" {
  value = azurerm_network_interface.example1.name
}

output "network_interface2_name" {
  value = azurerm_network_interface.example2.name
}

output "mysql_server_name" {
  value = azurerm_mysql_server.example.name
}

output "network_security_group_name" {
  value = azurerm_network_security_group.example.name
}