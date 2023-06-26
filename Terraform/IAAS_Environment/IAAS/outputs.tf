output "vm1_ip_address" {
  value = azurerm_virtual_machine.example1.private_ip_address
}

output "vm2_ip_address" {
  value = azurerm_virtual_machine.example2.private_ip_address
}

output "mysql_server_fqdn" {
  value = azurerm_mysql_server.example.fully_qualified_domain_name
}

output "frontdoor_profile_id" {
  value = azurerm_cdn_frontdoor_profile.example.id
}

output "frontdoor_endpoint_name" {
  value = azurerm_cdn_frontdoor_endpoint.example.name
}
