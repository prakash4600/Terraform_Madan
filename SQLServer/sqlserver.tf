provider "azurerm" {
  features {}
}


resource "azurerm_sql_server" "sqlserver" {
  name                = "ccpsqlserver463"
  resource_group_name = "My_Terraform_Practice"
  location            = "East US"
  version             = "12.0"  # Choose the desired SQL Server version

  administrator_login          = "sqladmin"
  administrator_login_password = "MyP@ssw0rd!"  # Replace with your desired password
}

resource "azurerm_sql_database" "sqldatabase" {
  name                = "my-sql-database"
  resource_group_name = "My_Terraform_Practice"
  location            = "East US"
  server_name         = azurerm_sql_server.sqlserver.name
  edition             = "Basic"  # Choose the desired database edition
  requested_service_objective_name = "Basic"  # Choose the desired performance level
  collation           = "SQL_Latin1_General_CP1_CI_AS"

  tags = {
    environment = "dev"
  }
}

output "server_name" {
  value = azurerm_sql_server.sqlserver.name
}

output "server_fqdn" {
  value = azurerm_sql_server.sqlserver.fully_qualified_domain_name
}

output "server_username" {
  value = azurerm_sql_server.sqlserver.administrator_login
}

output "server_password" {
  value = azurerm_sql_server.sqlserver.administrator_login_password
}

output "database_name" {
  value = azurerm_sql_database.sqldatabase.name
}
