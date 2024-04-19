resource "azurerm_resource_group" "rg_hub" {
  name     = var.rg_hub-name
  location = var.location

  tags = var.tags
}

resource "azurerm_virtual_network" "vnet_hub" {
  name                = var.vnet_hub-name
  location            = azurerm_resource_group.rg_hub.location
  resource_group_name = azurerm_resource_group.rg_hub.name
  address_space       = var.vnet_hub-address_space

  tags = var.tags
}

resource "azurerm_subnet" "subnet_hub" {
  name                 = var.hub-subnet_names[count.index]
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  resource_group_name  = azurerm_resource_group.rg_hub.name
  address_prefixes     = [var.hub-subnet_prefixes[count.index]]
  count                = length(var.hub-subnet_names)
}