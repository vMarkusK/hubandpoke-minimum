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

data "azuread_client_config" "this" {}

resource "time_static" "current" {}

resource "random_string" "encryption_compute" {
  length  = 6
  special = false
  upper   = false
  numeric = true
  lower   = true
}

resource "azurerm_user_assigned_identity" "encryption_compute" {
  name                = "uai-compute-${random_string.encryption_compute.result}"
  resource_group_name = azurerm_resource_group.rg_compute.name
  location            = azurerm_resource_group.rg_compute.location

  tags = var.tags
}

#trivy:ignore:AVD-AZU-0013
resource "azurerm_key_vault" "encryption_compute" {
  name                = "kv-compute-${random_string.encryption_compute.result}"
  resource_group_name = azurerm_resource_group.rg_compute.name
  location            = azurerm_resource_group.rg_compute.location

  sku_name                   = "standard"
  tenant_id                  = data.azuread_client_config.this.tenant_id
  enable_rbac_authorization  = true
  purge_protection_enabled   = true
  soft_delete_retention_days = 7

  enabled_for_disk_encryption = true

  tags = var.tags
}

resource "azurerm_role_assignment" "encryption_compute" {
  scope                = azurerm_key_vault.encryption_compute.id
  role_definition_name = "Key Vault Crypto User"
  principal_id         = azurerm_user_assigned_identity.encryption_compute.principal_id
}

resource "azurerm_role_assignment" "encryption_compute_extended" {
  scope                = azurerm_key_vault.encryption_compute.id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_user_assigned_identity.encryption_compute.principal_id
}

resource "azurerm_key_vault_key" "encryption_compute" {
  name         = "cmk-compute-${formatdate("YYYYMMDD-hhmm", time_static.current.rfc3339)}"
  key_vault_id = azurerm_key_vault.encryption_compute.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_disk_encryption_set" "encryption_compute" {
  name                = "des-compute-${random_string.encryption_compute.result}"
  resource_group_name = azurerm_resource_group.rg_compute.name
  location            = azurerm_resource_group.rg_compute.location
  key_vault_key_id    = azurerm_key_vault_key.encryption_compute.id

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.encryption_compute.id
    ]
  }

  tags = var.tags

  depends_on = [azurerm_role_assignment.encryption_compute, azurerm_role_assignment.encryption_compute_extended]
}