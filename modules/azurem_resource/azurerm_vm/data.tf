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
    resource_group_name = "rg-kv"
  
}

data "azurerm_key_vault_secret" "vm-admin_username" {
    name = "vm-username"
    key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "vm-passwd" {
    name = "vm-passwd"
    key_vault_id = data.azurerm_key_vault.kv.id 
}