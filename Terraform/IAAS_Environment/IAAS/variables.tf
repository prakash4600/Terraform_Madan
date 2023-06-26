variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "ccpterraform"
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
  default     = "West US"
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
  default     = "ccp_terraform_vnet"
}

variable "virtual_machine_size" {
  description = "The size of the virtual machines."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "admin_username" {
  description = "The admin username for the virtual machines."
  type        = string
  default     = "adminuser"
}

variable "admin_password" {
  description = "The admin password for the virtual machines."
  type        = string
  default     = "AdminPassword123!"
}

variable "mysql_admin_username" {
  description = "The admin username for the MySQL server."
  type        = string
  default     = "mysqladminun"
}

variable "mysql_admin_password" {
  description = "The admin password for the MySQL server."
  type        = string
  default     = "H@Sh1CoR3!"
}
