module "spoke1network" {
  source                  = "./modules/spokedefault"
  vnet_name               = var.spoke1_vnet_name
  resource_group_name     = var.spoke1_rg_name
  location                = var.location
  address_space           = var.spoke1_address_space
  subnet_prefixes         = var.spoke1_subnet_prefixes
  subnet_names            = var.spoke1_subnet_names
  hub-resource_group_name = azurerm_resource_group.rg_hub.name
  hub-vnet_name           = azurerm_virtual_network.vnet_hub.name
  hub-vnet_id             = azurerm_virtual_network.vnet_hub.id
  router-private-ip       = module.ubunturoutervm.vmnicip
  hub-vnet_address_space  = tostring(var.vnet_hub-address_space[0])
  tags                    = var.tags
}