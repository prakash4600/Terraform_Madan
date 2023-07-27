provider "azurerm" {
  features {}
}



resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "mrg4tetappserviceplan"
  location            = "My_Terraform_Practice"
  resource_group_name = "My_Terraform_Practice"

  sku {
    tier = "Standard"
    size = "S1"  # Change this to your desired pricing tier and size
  }
}

resource "azurerm_app_service" "app_service" {
  name                = "myappservic56574e"
  location            = "My_Terraform_Practice"
  resource_group_name = "My_Terraform_Practice"
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  site_config {
    always_on = true
    # Additional configurations can be added here, such as app settings, connection strings, etc.
  }

  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "14"  # Change this to your desired Node.js version
  }

  tags = {
    environment = "dev"
  }
}

output "app_service_name" {
  value = azurerm_app_service.app_service.name
}

output "app_service_default_hostname" {
  value = azurerm_app_service.app_service.default_site_hostname
}
