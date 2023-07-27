provider "azurerm" {
  features {}
}


resource "azurerm_app_service_plan" "container_app_service_plan" {
  name                = "mycontainerappserviceplan345345"
  location            = "East US"
  resource_group_name = "My_Terraform_Practice"

  sku {
    tier = "Standard"
    size = "S1"  # Change this to your desired pricing tier and size
  }
}

resource "azurerm_function_app" "container_app" {
  name                = "mycontainer34534app"
  location            = "East US"
  resource_group_name = "My_Terraform_Practice"
  app_service_plan_id = azurerm_app_service_plan.container_app_service_plan.id

  os_type = "Linux"

  site_config {
    always_on = true
    # Additional configurations can be added here, such as app settings, connection strings, etc.
  }

  app_settings = {
    # You can add any necessary environment variables here.
  }

  tags = {
    environment = "dev"
  }
}

output "container_app_name" {
  value = azurerm_function_app.container_app.name
}

output "container_app_default_hostname" {
  value = azurerm_function_app.container_app.default_hostname
}
