# General
variable "subscription_id" {
  description = "Subscription ID for all resources"
  type        = string
}

variable "location" {
  description = "Location for all resources"
  type        = string
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)
}

# Hub
variable "hub_rg_name" {
  description = "Name of the Hub RG"
  type        = string
}

variable "hub_vnet_name" {
  description = "Name of the Hub VNet"
  type        = string
}

variable "hub_vnet_addressspace" {
  description = "Address Space of the Hub VNet"
  type        = list(string)
}

variable "hub_vnet_subnets" {
  description = "Subnets of the Hub VNet"
  type = list(object({
    name = string
    cidr = list(string)
  }))
}

# Spoke1
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

variable "spoke1_vnet_subnets" {
  description = "Subnets of the spoke1 VNet"
  type = list(object({
    name = string
    cidr = list(string)
  }))
}

# Spoke2
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

variable "spoke2_vnet_subnets" {
  description = "Subnets of the spoke2 VNet"
  type = list(object({
    name = string
    cidr = list(string)
  }))
}

# Compute General
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

variable "vm_size" {
  description = "Size of the VMs"
  type        = string
}

variable "vm_size_router" {
  description = "Size of the router VM"
  type        = string
}

# Compute Spoke1
variable "spoke1_vm_hostname" {
  description = "Hostname of spoke1 VM"
  type        = string
}

# Compute Spoke2
variable "spoke2_vm_hostname" {
  description = "Hostname of spoke1 VM"
  type        = string
}

# Compute Hub-Router
variable "hub_router_hostname" {
  description = "Hostname of Router VM"
  type        = string
}

variable "myip" {
  description = "My OnPrem IP to Access Router"
  type        = string
}


