module "ubunturoutervm" {
  source                 = "./modules/ubunturoutervm"
  rgname                 = azurerm_resource_group.rg_compute.name
  location               = var.location
  subnetid               = azurerm_subnet.hub_subnet["RouterSubnet"].id
  vmname                 = var.hub_router_hostname
  vmpassword             = data.azurerm_key_vault_secret.vmpassword.value
  adminusername          = var.vm_admin_user
  vmsize                 = var.vm_size_router
  cloudconfig_file_linux = var.cloudconfig_file_linux

  tags = var.tags
}
