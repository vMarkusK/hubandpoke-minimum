module "ubuntuspoke2" {
  source                 = "./modules/ubuntuvm"
  rgname                 = azurerm_resource_group.rg_compute.name
  location               = var.location
  subnetid               = module.spoke2network.vnet_subnets[0]
  vmname                 = var.spoke2_vm_hostname
  vmpassword             = data.azurerm_key_vault_secret.vmpassword.value
  adminusername          = var.vm_admin_user
  vmsize                 = var.vm_size
  cloudconfig_file_linux = var.cloudconfig_file_linux
  tags                   = var.tags

  depends_on = [module.ubunturoutervm]
}