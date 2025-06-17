module "vm1" {
  depends_on = [ module.subnet ]
  source = "../modules/azurem_resource/azurerm_vm"

  resource_group_name = "rg-0605"
  location            = "centralIndia"
  linux_virtual_machine       =  "vm-deploy"
  size             =  "Standard_B1s"
  publisher      = "Canonical"
  offer          = "0001-com-ubuntu-server-focal"
  sku            = "20_04-lts"
  nic_name             = "nic-practice"
  public_ip_name    = "pip-practice"
  virtual_network_name         = "vnet-dev"
  subnet_name = "subnet-practice"
}



module "public_ip"{
  depends_on = [ module.subnet ]
source = "../modules/azurem_resource/azurerm_public_ip"
public_ip_name = "pip-practice"
resource_group_name = "rg-0605"
location = "CentralIndia"

}




module "resource_group" {
  source = "../modules/azurem_resource/azurerm_rg"

  resource_group_name = "rg-0605"
  location            = "centralIndia"
  
}
module "virtual_network" {
  depends_on = [ module.resource_group ]
  source = "../modules/azurem_resource/azurerm_vnet"
  
location = "CentralIndia"
  resource_group_name = "rg-0605"
  virtual_network_name = "vnet-dev"
  address_space       = ["10.0.0.0/16"]

}
module "subnet" {
  depends_on = [ module.virtual_network ]
  source = "../modules/azurem_resource/azurerm_subnet"
    

  resource_group_name    = "rg-0605"
  virtual_network_name   = "vnet-dev"
  subnet_name            = "subnet-practice"
  
}
module "sql_server" {
  depends_on = [ module.resource_group ]
  source = "../modules/azurem_resource/azurerm_server"

  resource_group_name = "rg-0605"
  sql_server_name     = "dev-server86768"
  location            = "centralIndia"
  
}

module "sql_database" {
  depends_on = [ module.sql_server ]
  source = "../modules/azurem_resource/azurerm_db"
  
  
  
    db_name = "dev-db"
  
}
