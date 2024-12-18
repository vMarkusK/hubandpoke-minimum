module "spoke2network" {
  source                  = "./modules/spokedefault"
  vnet_name               = var.spoke2_vnet_name
  resource_group_name     = var.spoke2_rg_name
  location                = var.location
  address_space           = var.spoke2_address_space
  subnets                 = var.spoke2_vnet_subnets
  hub-resource_group_name = azurerm_resource_group.rg_hub.name
  hub-vnet_name           = azurerm_virtual_network.hub_vnet.name
  hub-vnet_id             = azurerm_virtual_network.hub_vnet.id
  router-private-ip       = module.ubunturoutervm.vmnicip
  hub-vnet_address_space  = tostring(var.hub_vnet_addressspace[0])
  tags                    = var.tags
}
