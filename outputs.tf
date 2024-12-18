output "vm_username" {
  value = var.vm_admin_user
}

output "spoke1_vm_private_ip" {
  value = module.ubuntuspoke1.vmnicip
}

output "spoke2_vm_private_ip" {
  value = module.ubuntuspoke2.vmnicip
}

output "router_vm_private_ip" {
  value = module.ubunturoutervm.vmnicip
}

output "router_public_dns_fqdn" {
  value = module.ubunturoutervm.pip_fqdn
}

output "router_public_ip" {
  value = module.ubunturoutervm.pip_ip
}
