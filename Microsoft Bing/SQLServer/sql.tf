module "mssql-db" {
  source              = "kumarvna/mssql-db/azurerm"
  resource_group_name = "rg-mssql-db"
  location            = "eastus"
  sql_server_name     = "sqlserver68324986"
  sql_db_name         = "sqldb"
  sql_username        = "sqladmin"
  sql_password        = "P@ssw0rd1234!"
}
