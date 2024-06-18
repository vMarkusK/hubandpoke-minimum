location = "swedencentral"
tags = {
  applicationname = "SpokeVendingMachine"
  environment     = "Dev"
  supportgroup    = "Markus Kraus"
}
rg_hub-name            = "rg-net-hub-001"
vnet_hub-name          = "vnet_hub-001"
vnet_hub-address_space = ["10.0.0.0/16"]
hub-subnet_names       = ["RouterSubnet"]
hub-subnet_prefixes    = ["10.0.0.0/26"]
spoke1_rg_name         = "rg-spoke1-001"
spoke1_vnet_name       = "vnet-spoke1-001"
spoke1_address_space   = "10.100.0.0/16"
spoke1_subnet_names    = ["WebTier", "LogicTier", "DatabaseTier"]
spoke1_subnet_prefixes = ["10.100.1.0/24", "10.100.2.0/24", "10.100.3.0/24"]
spoke2_rg_name         = "rg-spoke2-001"
spoke2_vnet_name       = "vnet-spoke2-001"
spoke2_address_space   = "10.101.0.0/16"
spoke2_subnet_names    = ["WebTier", "LogicTier", "DatabaseTier"]
spoke2_subnet_prefixes = ["10.101.1.0/24", "10.101.2.0/24", "10.101.3.0/24"]
rg_compute_name        = "rg-compute-001"
cloudconfig_file_linux = "cloudconfig_linux.tpl"
vm_admin_user          = "azureuser"
vm_size                = "Standard_B1s"
vm_size_router         = "Standard_B1s"
spoke1_vm_hostname     = "vm-spoke1-dev-001"
spoke2_vm_hostname     = "vm-spoke2-dev-001"
hub_router_hostname    = "vm-hub-dev-001"
myip                   = "93.219.74.211/32"