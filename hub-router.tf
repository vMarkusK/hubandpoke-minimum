module "ubunturoutervm" {
  source                 = "./modules/ubunturoutervm"
  rgname                 = azurerm_resource_group.rg_compute.name
  location               = var.location
  subnetid               = azurerm_subnet.subnet_hub[0].id
  vmname                 = var.hub_router_hostname
  vmpassword             = var.vm_admin_pwd
  adminusername          = var.vm_admin_user
  vmsize                 = var.vm_size_router
  cloudconfig_file_linux = var.cloudconfig_file_linux
  tags                   = var.tags
}