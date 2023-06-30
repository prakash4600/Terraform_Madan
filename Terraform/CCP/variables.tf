variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "ccp-resource-group4600"
}

variable "location" {
  description = "Location for Azure resources"
  type        = string
  default     = "Brazil South"
}

variable "dns_zone_name" {
  description = "Name of the DNS zone"
  type        = string
  default     = "sub-domain.domain.com"
}

variable "cdn_profile_name" {
  description = "Name of the CDN front door profile"
  type        = string
  default     = "ccp-profile4600"
}

variable "cdn_custom_domain_name" {
  description = "Name of the CDN custom domain"
  type        = string
  default     = "ccp-customDomain4600"
}

variable "cdn_custom_domain_host_name" {
  description = "Host name for the CDN custom domain"
  type        = string
  default     = "contoso.fabrikam.com"
}

variable "mysql_server_name" {
  description = "Name of the MySQL server"
  type        = string
  default     = "ccp-mysqlserver4600"
}

variable "mysql_admin_login" {
  description = "MySQL server administrator login"
  type        = string
  default     = "mysqladminun"
}

variable "mysql_admin_password" {
  description = "MySQL server administrator password"
  type        = string
  default     = "H@Sh1CoR3!"
}

variable "service_plan_name" {
  description = "Name of the app service plan"
  type        = string
  default     = "ccp4600"
}

variable "web_app_name" {
  description = "Name of the web app"
  type        = string
  default     = "ccpterraform4600"
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
  default     = "ccpstorageaccount4600"
}

variable "storage_container_name" {
  description = "Name of the storage container"
  type        = string
  default     = "blobstorage4600"
}

variable "container_registry_name" {
  description = "Name of the container registry"
  type        = string
  default     = "ccpcontainerregistry4600"
}

variable "log_analytics_workspace_name" {
  description = "Name of the log analytics workspace"
  type        = string
  default     = "acctest-01"
}

variable "container_app_environment_name" {
  description = "Name of the container app environment"
  type        = string
  default     = "ccp-Environment4600"
}

variable "container_app_name" {
  description = "Name of the container app"
  type        = string
  default     = "ccp-container-app4600"
}

variable "key_vault_name" {
  description = "Name of the key vault"
  type        = string
  default     = "ccpkeyvault4600"
}
