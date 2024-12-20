module "ubuntuspoke2" {
  source        = "./modules/ubuntuvm"
  rgname        = azurerm_resource_group.rg_compute.name
  location      = var.location
  subnetid      = module.spoke2network.vnet_subnets["WebTier"].id
  vmname        = var.spoke2_vm_hostname
  vmpassword    = data.azurerm_key_vault_secret.vmpassword.value
  adminusername = var.vm_admin_user
  vmsize        = var.vm_size
  tags          = var.tags

  depends_on = [module.ubunturoutervm]
}