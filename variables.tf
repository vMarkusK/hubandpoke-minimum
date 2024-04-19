variable "location" {
  description = "Location for all resources"
  type        = string
  default     = "swedencentral"
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {
    applicationname = "SpokeVendingMachine"
    environment     = "Dev"
    supportgroup    = "Markus Kraus"
  }
}

// Hub
variable "rg_hub-name" {
  description = "Name of the Hub RG"
  type        = string
  default     = "rg-net-hub-001"
}

variable "vnet_hub-name" {
  description = "Name of the Hub VNet"
  type        = string
  default     = "vnet_hub-001"
}

variable "vnet_hub-address_space" {
  description = "Address Space of the Hub VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "hub-subnet_names" {
  description = "Subnet Names of the Hub VNet"
  type        = list(string)
  default     = ["AzureFirewallSubnet", "NetworkGatewaySubnet", "ApplicationGatewaySubnet"]
}

variable "hub-subnet_prefixes" {
  description = "Subnet Prefixes of the Hub VNet"
  type        = list(string)
  default     = ["10.0.0.0/26", "10.0.0.64/26", "10.0.0.128/26"]
}

// Spoke1
variable "spoke1_rg_name" {
  description = "spoke1 RG name"
  type        = string
  default     = "rg-spoke1-001"
}

variable "spoke1_vnet_name" {
  description = "spoke1 vnet name"
  type        = string
  default     = "vnet-spoke1-001"
}

variable "spoke1_address_space" {
  description = "spoke1 Address Space"
  type        = string
  default     = "10.100.0.0/16"
}

variable "spoke1_subnet_names" {
  description = "spoke1 Subnet Names"
  type        = list(string)
  default     = ["WebTier", "LogicTier", "DatabaseTier"]
}

variable "spoke1_subnet_prefixes" {
  description = "spoke1 Subnet prefixes"
  type        = list(string)
  default     = ["10.100.1.0/24", "10.100.2.0/24", "10.100.3.0/24"]
}

// Spoke2
variable "spoke2_rg_name" {
  description = "spoke2 RG name"
  type        = string
  default     = "rg-spoke2-001"
}

variable "spoke2_vnet_name" {
  description = "spoke2 vnet name"
  type        = string
  default     = "vnet-spoke2-001"
}

variable "spoke2_address_space" {
  description = "spoke2 Address Space"
  type        = string
  default     = "10.101.0.0/16"
}

variable "spoke2_subnet_names" {
  description = "spoke2 Subnet Names"
  type        = list(string)
  default     = ["WebTier", "LogicTier", "DatabaseTier"]
}

variable "spoke2_subnet_prefixes" {
  description = "spoke2 Subnet prefixes"
  type        = list(string)
  default     = ["10.101.1.0/24", "10.101.2.0/24", "10.101.3.0/24"]
}

// Compute General
variable "rg_compute_name" {
  description = "Compute RG Name"
  type        = string
  default     = "rg-compute-001"
}

variable "cloudconfig_file_linux" {
  description = "The location of the cloud init configuration file."
  type        = string
  default     = "cloudconfig_linux.tpl"
}

variable "vm_admin_user" {
  description = "Username for Virtual Machines"
  type        = string
  default     = "azureuser"
}
variable "vm_admin_pwd" {
  description = "Password for Virtual Machines"
  type        = string
  sensitive   = true
}

variable "vm_size" {
  description = "Size of the VMs"
  type        = string
  default     = "Standard_B1s"
}

// Compute Spoke1
variable "spoke1_vm_hostname" {
  description = "Hostname of spoke1 VM"
  type        = string
  default     = "vm-spoke1-dev-001"
}

// Compute Spoke2
variable "spoke2_vm_hostname" {
  description = "Hostname of spoke1 VM"
  type        = string
  default     = "vm-spoke2-dev-001"
}

// Compute Hub-Router
variable "hub_router_hostname" {
  description = "Hostname of Router VM"
  type        = string
  default     = "vm-hub-dev-001"
}



