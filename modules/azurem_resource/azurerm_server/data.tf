data "azurerm_key_vault" "kv" {
    name = "locker-kv"
    resource_group_name = "rg-kv"
  
}

data "azurerm_key_vault_secret" "db-server" {
    name = "server-username"
    key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "vm-passwd" {
    name = "server-passwd"
    key_vault_id = data.azurerm_key_vault.kv.id 
}