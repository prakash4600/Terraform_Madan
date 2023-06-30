variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "ccpterraform"
}

variable "location" {
  description = "Azure region for deploying resources"
  type        = string
  default     = "West US"
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "ccp_terraform_vnet"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "ccp_terraform_subnet"
}

variable "frontdoor_profile_name" {
  description = "Name of the CDN Front Door profile"
  type        = string
  default     = "example-profile"
}

variable "frontdoor_endpoint_name" {
  description = "Name of the CDN Front Door endpoint"
  type        = string
  default     = "example-endpoint"
}

variable "virtual_machine1_name" {
  description = "Name of the first virtual machine"
  type        = string
  default     = "ccp_terraform_vm1"
}

variable "virtual_machine2_name" {
  description = "Name of the second virtual machine"
  type        = string
  default     = "ccp_terraform_vm2"
}

variable "network_interface1_name" {
  description = "Name of the first network interface"
  type        = string
  default     = "ccp_terraform_nic1"
}

variable "network_interface2_name" {
  description = "Name of the second network interface"
  type        = string
  default     = "ccp_terraform_nic2"
}

variable "mysql_server_name" {
  description = "Name of the MySQL server"
  type        = string
  default     = "ccpterraformmysqlserver"
}

variable "mysql_admin_username" {
  description = "Username for the MySQL server admin"
  type        = string
  default     = "mysqladminun"
}

variable "mysql_admin_password" {
  description = "Password for the MySQL server admin"
  type        = string
  default     = "H@Sh1CoR3!"
}

variable "network_security_group_name" {
  description = "Name of the network security group"
  type        = string
  default     = "ccp_terraform_nsg"
}