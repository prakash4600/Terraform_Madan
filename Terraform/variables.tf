variable "resource_group_name" {
  description = "Name of the Azure Resource Group."
  type        = string
  default     = "Terraform_TFVARS"
}

variable "location" {
  description = "Azure region where the resources will be deployed."
  type        = string
  default     = "West US"
}

variable "storage_account_name" {
  description = "Name of the Azure Storage Account."
  type        = string
  default     = "tfvarsfile4674"
}

variable "container_name" {
  description = "Name of the Azure Storage Container."
  type        = string
  default     = "Bhanu"
}
