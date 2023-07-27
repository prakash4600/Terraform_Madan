provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "function_app_rg" {
  name     = "example-resource-group232"
  #location = "East US"  # Update with your desired location
}

# Storage Account
resource "azurerm_storage_account" "function_app_storage" {
  name                     = "myfunctionappstorage"  # Update with a unique name
  resource_group_name      = "example-resource-group232"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Function App
resource "azurerm_function_app" "function_app" {
  name                      = "my-function-app"
  location                  = "East US"
  resource_group_name       = "example-resource-group232"
  app_service_plan_id       = azurerm_app_service_plan.function_app_asp.id
  storage_connection_string = azurerm_storage_account.function_app_storage.primary_connection_string

  version {
    function_app_version = "~3"
  }

  site_config {
    app_settings = [
      # Add any environment-specific settings here
      # Example: { name = "MySetting", value = "MyValue" }
    ]

    always_on                 = true
    use_32_bit_worker_process = true
    linux_fx_version          = "DOTNET|5.0"  # Change this for different runtime (e.g., "DOTNET|3.1", "PYTHON|3.8", etc.)
  }
}

# App Service Plan
resource "azurerm_app_service_plan" "function_app_asp" {
  name                = "my-function-app-asp"
  location            = "East US"
  resource_group_name = "example-resource-group232"
  kind                = "FunctionApp"
  reserved            = true

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

output "function_app_url" {
  value = azurerm_function_app.function_app.default_hostname
}
