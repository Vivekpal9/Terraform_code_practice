resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                        ="internal"
    subnet_id                     = data.azurerm_subnet.snet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = data.azurerm_public_ip.pip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm1"{
 
 name = var.linux_virtual_machine
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = data.azurerm_key_vault_secret.vm-admin_username.value
  admin_password = data.azurerm_key_vault_secret.vm-passwd.value
  disable_password_authentication = false
  network_interface_ids = [ azurerm_network_interface.nic.id
  ]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }
}