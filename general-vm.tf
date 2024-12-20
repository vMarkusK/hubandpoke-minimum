resource "azurerm_resource_group" "rg_compute" {
  name     = var.rg_compute_name
  location = var.location
  tags     = var.tags
}

data "azurerm_key_vault" "secrets" {
  name                = "kv-tf-infra-sec-001"
  resource_group_name = "rg-tf-infra-001"
}

data "azurerm_key_vault_secret" "vmpassword" {
  name         = "vmpassword"
  key_vault_id = data.azurerm_key_vault.secrets.id
}
