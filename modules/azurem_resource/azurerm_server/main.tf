resource "azurerm_mssql_server" "db_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = data.azurerm_key_vault_secret.db-server.value
  administrator_login_password = data.azurerm_key_vault_secret.vm-passwd.value
}