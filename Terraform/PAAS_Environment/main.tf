#resource group

resource "azurerm_resource_group" "ccp" {
  name     = "ccp-resource-group"
  location = "Brazil South"
}

#front door cdn

resource "azurerm_dns_zone" "ccp" {
  name                = "sub-domain.domain.com"
  resource_group_name = azurerm_resource_group.ccp.name
}

resource "azurerm_cdn_frontdoor_profile" "ccp" {
  name                = "ccp-profile460"
  resource_group_name = azurerm_resource_group.ccp.name
  sku_name            = "Standard_AzureFrontDoor"
}

resource "azurerm_cdn_frontdoor_custom_domain" "ccp" {
  name                     = "ccp-customDomain460"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.ccp.id
  dns_zone_id              = azurerm_dns_zone.ccp.id
  host_name                = "contoso.fabrikam.com"

  tls {
    certificate_type    = "ManagedCertificate"
    minimum_tls_version = "TLS12"
  }
}

#mysql server

resource "azurerm_mysql_server" "ccp" {
  name                = "ccp-mysqlserver460"
  location            = azurerm_resource_group.ccp.location
  resource_group_name = azurerm_resource_group.ccp.name

  administrator_login          = "mysqladminun"
  administrator_login_password = "H@Sh1CoR3!"

  sku_name   = "B_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

#app service plan

resource "azurerm_service_plan" "ccp" {
  name                = "ccp460"
  resource_group_name = azurerm_resource_group.ccp.name
  location            = azurerm_resource_group.ccp.location
  sku_name            = "P1v2"
  os_type             = "Windows"
}

#app service

resource "azurerm_windows_web_app" "ccp" {
  name                = "ccpterraform460"
  resource_group_name = azurerm_resource_group.ccp.name
  location            = azurerm_service_plan.ccp.location
  service_plan_id     = azurerm_service_plan.ccp.id

  site_config {}
}

#storage account

resource "azurerm_storage_account" "ccp" {
  name                     = "ccpstorageaccount460"
  resource_group_name      = azurerm_resource_group.ccp.name
  location                 = azurerm_resource_group.ccp.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}

#blob container

resource "azurerm_storage_container" "ccp" {
  name                  = "blobstorage460"
  storage_account_name  = azurerm_storage_account.ccp.name
  container_access_type = "private"
}

#container registry

resource "azurerm_container_registry" "acr" {
  name                = "ccpcontainerregistry460"
  resource_group_name = azurerm_resource_group.ccp.name
  location            = azurerm_resource_group.ccp.location
  sku                 = "Premium"
  admin_enabled       = true
}

#container apps

resource "azurerm_log_analytics_workspace" "ccp" {
  name                = "acctest-01"
  location            = azurerm_resource_group.ccp.location
  resource_group_name = azurerm_resource_group.ccp.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "ccp" {
  name                       = "ccp-Environment460"
  location                   = azurerm_resource_group.ccp.location
  resource_group_name        = azurerm_resource_group.ccp.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.ccp.id
}
resource "azurerm_container_app" "ccp" {
  name                         = "ccp-container-app460"
  container_app_environment_id = azurerm_container_app_environment.ccp.id
  resource_group_name          = azurerm_resource_group.ccp.name
  revision_mode                = "Single"

  template {
    container {
      name   = "ccpcontainerapp"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
}

#key vault

#ccp Usage
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "ccp" {
  name                        = "ccpkeyvault460"
  location                    = azurerm_resource_group.ccp.location
  resource_group_name         = azurerm_resource_group.ccp.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

