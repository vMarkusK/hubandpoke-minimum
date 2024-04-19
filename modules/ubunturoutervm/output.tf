output "vmnicip" {
  description = "the ip address of the vm"
  value       = azurerm_network_interface.spokevmnic.private_ip_address
}

output "id" {
  description = "id of the provisioned vm"
  value       = azurerm_virtual_machine.spokevm.id
}

output "pip_fqdn" {
  value = azurerm_public_ip.pip_spokevmnic.fqdn
}

output "pip_ip" {
  value = azurerm_public_ip.pip_spokevmnic.ip_address
}