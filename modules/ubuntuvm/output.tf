output "vmnicip" {
  description = "the ip address of the vm"
  value       = azurerm_network_interface.spokevmnic.private_ip_address
}

output "id" {
  description = "id of the provisioned vm"
  value       = azurerm_linux_virtual_machine.spokevm.id
}

output "pip_fqdn" {
  value = var.router ? azurerm_public_ip.pip_spokevmnic[0].fqdn : null
}

output "pip_ip" {
  value = var.router ? azurerm_public_ip.pip_spokevmnic[0].ip_address : null
}
