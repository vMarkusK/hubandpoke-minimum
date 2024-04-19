variable "location" {
  description = "Location for all resources"
  type        = string
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)
}

// Hub
variable "rg_hub-name" {
  description = "Name of the Hub RG"
  type        = string
}

variable "vnet_hub-name" {
  description = "Name of the Hub VNet"
  type        = string
}

variable "vnet_hub-address_space" {
  description = "Address Space of the Hub VNet"
  type        = list(string)
}

variable "hub-subnet_names" {
  description = "Subnet Names of the Hub VNet"
  type        = list(string)
}

variable "hub-subnet_prefixes" {
  description = "Subnet Prefixes of the Hub VNet"
  type        = list(string)
}

// Spoke1
variable "spoke1_rg_name" {
  description = "spoke1 RG name"
  type        = string
}

variable "spoke1_vnet_name" {
  description = "spoke1 vnet name"
  type        = string
}

variable "spoke1_address_space" {
  description = "spoke1 Address Space"
  type        = string
}

variable "spoke1_subnet_names" {
  description = "spoke1 Subnet Names"
  type        = list(string)
}

variable "spoke1_subnet_prefixes" {
  description = "spoke1 Subnet prefixes"
  type        = list(string)
}

// Spoke2
variable "spoke2_rg_name" {
  description = "spoke2 RG name"
  type        = string
}

variable "spoke2_vnet_name" {
  description = "spoke2 vnet name"
  type        = string
}

variable "spoke2_address_space" {
  description = "spoke2 Address Space"
  type        = string
}

variable "spoke2_subnet_names" {
  description = "spoke2 Subnet Names"
  type        = list(string)
}

variable "spoke2_subnet_prefixes" {
  description = "spoke2 Subnet prefixes"
  type        = list(string)
}

// Compute General
variable "rg_compute_name" {
  description = "Compute RG Name"
  type        = string
}

variable "cloudconfig_file_linux" {
  description = "The location of the cloud init configuration file."
  type        = string
}

variable "vm_admin_user" {
  description = "Username for Virtual Machines"
  type        = string
}
variable "vm_admin_pwd" {
  description = "Password for Virtual Machines"
  type        = string
  sensitive   = true
}

variable "vm_size" {
  description = "Size of the VMs"
  type        = string
}

variable "vm_size_router" {
  description = "Size of the router VM"
  type        = string
}

// Compute Spoke1
variable "spoke1_vm_hostname" {
  description = "Hostname of spoke1 VM"
  type        = string
}

// Compute Spoke2
variable "spoke2_vm_hostname" {
  description = "Hostname of spoke1 VM"
  type        = string
}

// Compute Hub-Router
variable "hub_router_hostname" {
  description = "Hostname of Router VM"
  type        = string
}



