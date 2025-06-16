module "vm1" {
  source = "../modules/azurem_resource/virtual_machine"

  resource_group_name = ""
  virtual_network_name = ""
  subnet_name          = ""
  public_ip_name       = ""
  virtual_machine_name = "vm1-azurem"
  location             = module.resource_group.location
  admin_username       = "azureuser"
  admin_password       = "P@ssw0rd1234!"
  
}



module "public_ip"{
source = "../modules/azurem_resource/public_ip"
public_ip_name = "pip-azurem"
resource_group_name = "rg-azurem"
location = "eastus"
  allocation_method = "Static"
}




module "resource_group" {
  source = "../modules/azurem_resource/resource_group"

  resource_group_name = "rg-azurem"
  location            = "eastus"
  
}
module "virtual_network" {
  source = "../modules/azurem_resource/virtual_network"
  depends_on = [ module.resource_group ]

  resource_group_name = module.resource_group.resource_group_name
  virtual_network_name = "vnet-azurem"
  address_space       = ["10.0.0.0/16"]

}
module "subnet" {
  source = "../modules/azurem_resource/subnet"
    depends_on = [ module.virtual_network ]

  resource_group_name    = module.resource_group.resource_group_name
  virtual_network_name   = module.virtual_network.virtual_network_name
  subnet_name            = "subnet-azurem"
  
}
module "sql_server" {
  source = "../modules/azurem_resource/sql_server"

  resource_group_name = module.resource_group.resource_group_name
  sql_server_name     = "sqlserver-azurem"
  location            = module.resource_group.location
  administrator_login = "sqladmin"
  administrator_login_password = "P@ssw0rd1234!"
  
}

module "sql_database" {
  source = "../modules/azurem_resource/sql_database"
  depends_on = [ module.sql_server ]
  resource_group_name = module.resource_group.resource_group_name
  sql_server_name     = module.sql_server.sql_server_name
  sql_database_name   = "sqldb-azurem"
  
}
