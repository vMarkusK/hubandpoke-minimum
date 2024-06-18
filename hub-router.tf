module "ubunturoutervm" {
  source                 = "./modules/ubunturoutervm"
  rgname                 = azurerm_resource_group.rg_compute.name
  location               = var.location
  subnetid               = azurerm_subnet.subnet_hub[0].id
  vmname                 = var.hub_router_hostname
  vmpassword             = var.vm_admin_pwd
  adminusername          = var.vm_admin_user
  vmsize                 = var.vm_size_router
  cloudconfig_file_linux = var.cloudconfig_file_linux
  tags                   = var.tags
}

resource "azurerm_network_security_group" "nsg-router" {
  name                = "nsg-router"
  location            = azurerm_resource_group.rg_hub.location
  resource_group_name = azurerm_resource_group.rg_hub.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.myip
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HttpIn"
    priority                   = 1010
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "10.0.0.0/8"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "HttpsIn"
    priority                   = 1011
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "10.0.0.0/8"
    destination_address_prefix = "*"
  }

  tags = var.tags

}

resource "azurerm_subnet_network_security_group_association" "nsg-router-association" {
  subnet_id                 = azurerm_subnet.subnet_hub[0].id
  network_security_group_id = azurerm_network_security_group.nsg-router.id
}