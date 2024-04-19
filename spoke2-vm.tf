module "ubuntuspoke2" {
  source                 = "./modules/ubuntuvm"
  rgname                 = azurerm_resource_group.rg_compute.name
  location               = var.location
  subnetid               = module.spoke2network.vnet_subnets[0]
  vmname                 = var.spoke2_vm_hostname
  vmpassword             = var.vm_admin_pwd
  adminusername          = var.vm_admin_user
  vmsize                 = var.vm_size
  cloudconfig_file_linux = var.cloudconfig_file_linux
  tags                   = var.tags
}