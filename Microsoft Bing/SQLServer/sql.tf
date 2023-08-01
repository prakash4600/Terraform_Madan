#module "mssql-db" {
#  source              = "kumarvna/mssql-db/azurerm"
#  resource_group_name = "rg-mssql-db"
#  location            = "eastus"
#  sql_server_name     = "sqlserver68324986"
#  sql_db_name         = "sqldb"
#  sql_username        = "sqladmin"
#  sql_password        = "P@ssw0rd1234!"
#}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_sql_server" "example" {
  name                         = "sqlserver68324986"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = "exampleadmin"
  administrator_login_password = "H@Sh1CoR3!"
}

resource "azurerm_sql_database" "example" {
  name                = "example-sql-database"
  resource_group_name = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  server_name         = azurerm_sql_server.example.name
  edition             = "Standard"
  collation           = "SQL_Latin1_General_CP1_CI_AS"
}

