provider "azurerm" {
  features {}
}

# Resource Group
data "azurerm_resource_group" "example" {
  name     = "example-resource-group232"
  #location = "East US"  # Update with your desired location
}

# SQL Server
resource "azurerm_sql_server" "sql_server" {
  name                         = "my-sql-server232"
  resource_group_name          = "example-resource-group232"
  location                     = "East US"
  version                      = "12.0"  # Choose the SQL Server version (e.g., "12.0" for SQL Server 2019)
  administrator_login          = "useradmin"  # Replace with your desired admin username
  administrator_login_password = "MyP@ssw0rd!"  # Replace with your desired admin password

  tags = {
    environment = "dev"
  }
}

# SQL Database
resource "azurerm_sql_database" "sql_db" {
  name                = "my-sql-db"
  resource_group_name = "example-resource-group232"
  location            = "East US"
  server_name         = azurerm_sql_server.sql_server.name
  edition             = "Basic"  # Change to desired edition (e.g., "Standard", "Premium", etc.)
  collation           = "SQL_Latin1_General_CP1_CI_AS"

  # Optionally, you can configure database properties such as max size, auto pause, etc.
  # Uncomment and customize the properties as needed.
  # max_size_gb           = 1
  # read_scale_enabled    = false
  # zone_redundant        = false
  # auto_pause_delay      = 60

  tags = {
    environment = "dev"
  }
}

output "sql_server_name" {
  value = azurerm_sql_server.sql_server.name
}

output "sql_database_name" {
  value = azurerm_sql_database.sql_db.name
}
