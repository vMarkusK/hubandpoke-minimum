resource "azurerm_resource_group" "rg_compute" {
  name     = var.rg_compute_name
  location = var.location
  tags     = var.tags
}