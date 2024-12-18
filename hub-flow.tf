resource "random_id" "id_flownsg" {
  byte_length = 8
}

#TODO Storage Account Firewall Rules
resource "azurerm_storage_account" "flownsg" {
  name                = "flownsg${random_id.id_flownsg.hex}"
  location            = azurerm_resource_group.rg_hub.location
  resource_group_name = azurerm_resource_group.rg_hub.name

  account_tier               = "Standard"
  account_kind               = "StorageV2"
  account_replication_type   = "LRS"
  https_traffic_only_enabled = true
  min_tls_version            = "TLS1_2"

  tags = var.tags
}

#TODO Switch to VNet Flow Logs as soon as available (https://github.com/hashicorp/terraform-provider-azurerm/pull/26015)
#trivy:ignore:AVD-AZU-0049
resource "azurerm_network_watcher_flow_log" "nsg_router" {
  network_watcher_name = azurerm_network_watcher.networkwatcher_hub.name
  resource_group_name  = azurerm_resource_group.rg_hub.name
  name                 = "nsg_router-log"

  network_security_group_id = azurerm_network_security_group.nsg_router.id
  storage_account_id        = azurerm_storage_account.flownsg.id
  enabled                   = true
  version                   = 2

  retention_policy {
    enabled = true
    days    = 7
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.law_platform.workspace_id
    workspace_region      = azurerm_log_analytics_workspace.law_platform.location
    workspace_resource_id = azurerm_log_analytics_workspace.law_platform.id
    interval_in_minutes   = 10
  }

  tags = var.tags
}