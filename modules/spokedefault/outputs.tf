output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = azurerm_virtual_network.vnet-spoke.id
}

output "vnet_name" {
  description = "The Name of the newly created vNet"
  value       = azurerm_virtual_network.vnet-spoke.name
}

output "vnet_location" {
  description = "The location of the newly created vNet"
  value       = azurerm_virtual_network.vnet-spoke.location
}

output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = azurerm_virtual_network.vnet-spoke.address_space
}

output "vnet_subnets" {
  description = "The ids of subnets created inside the new vNet"
  value       = azurerm_subnet.subnet-spoke.*.id
}

output "vnet_rg_name" {
  description = "The name of the resource group the vnet is created in"
  value       = azurerm_resource_group.rg-spoke.name
}
output "subnet_prefixes" {
  description = "The adress prefixes of subnets created inside the new vNet"
  value       = azurerm_subnet.subnet-spoke.*.address_prefixes
}
