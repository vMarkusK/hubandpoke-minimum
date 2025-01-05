variable "rgname" {
  description = "Resource Group to deploy VM into"
}
variable "location" {
  description = "Resource Group location to deploy to"
}

variable "vmname" {
  description = "Name of the VM"
}

variable "subnetid" {
  description = "ID of the subnet to use for the VM deployment"
}

variable "vmsize" {
  description = "size of VM"
}

variable "vmpassword" {
  description = "Password for the VM"
}

variable "adminusername" {
  description = "Name of the admin account"
}

variable "router" {
  description = "Enable IP forwarding on the NIC"
  type        = bool
  default     = false
}

variable "bootdiagnostics" {
  description = "Enable Boot Diagnostics for the VM"
  type        = bool
  default     = false
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)
}
