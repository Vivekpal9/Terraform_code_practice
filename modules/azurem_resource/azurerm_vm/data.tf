data "azurerm_subnet" "snet"{
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name = var.resource_group_name
  
}
data "azurerm_public_ip" "pip"{
  name = var.public_ip_name
  resource_group_name = var.resource_group_name
  
}

data "azurerm_key_vault" "kv" {
    name = "locker-kv"
    resource_group_name = ""
  
}

data "azurerm_key_vault_secret" "name" {
    name = "example-secret"
    key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "name" {
    name = "example-secret"
    key_vault_id = data.azurerm_key_vault.kv.id 
}