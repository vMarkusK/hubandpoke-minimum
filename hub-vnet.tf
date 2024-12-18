resource "azurerm_resource_group" "rg_hub" {
  name     = var.hub_rg_name
  location = var.location

  tags = var.tags
}

resource "azurerm_virtual_network" "hub_vnet" {
  name                = var.hub_vnet_name
  location            = azurerm_resource_group.rg_hub.location
  resource_group_name = azurerm_resource_group.rg_hub.name
  address_space       = var.hub_vnet_addressspace

  tags = var.tags
}

resource "azurerm_subnet" "hub_subnet" {
  for_each = { for subnet in var.hub_vnet_subnets : subnet.name => subnet }

  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.rg_hub.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = each.value.cidr
}

resource "azurerm_network_security_group" "nsg_router" {
  name                = "nsg_router"
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

  security_rule {
    name                       = "NtpIn"
    priority                   = 1012
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "123"
    source_address_prefix      = "10.0.0.0/8"
    destination_address_prefix = "*"
  }

  tags = var.tags

}

resource "azurerm_subnet_network_security_group_association" "nsg_router-association" {
  subnet_id                 = azurerm_subnet.hub_subnet["RouterSubnet"].id
  network_security_group_id = azurerm_network_security_group.nsg_router.id
}