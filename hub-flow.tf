resource "random_id" "id_flow" {
  byte_length = 8
}

#TODO Storage Account Firewall Rules
resource "azurerm_storage_account" "flow" {
  name                = "stflow${random_id.id_flow.hex}"
  location            = azurerm_resource_group.rg_hub.location
  resource_group_name = azurerm_resource_group.rg_hub.name

  account_tier               = "Standard"
  account_kind               = "StorageV2"
  account_replication_type   = "LRS"
  https_traffic_only_enabled = true
  min_tls_version            = "TLS1_2"

  sas_policy {
    expiration_period = "90.00:00:00"
    expiration_action = "Log"
  }

  tags = var.tags
}

#TODO Switch to VNet Flow Logs as soon as available (https://github.com/hashicorp/terraform-provider-azurerm/pull/26015)
#trivy:ignore:AVD-AZU-0049
resource "azurerm_network_watcher_flow_log" "hub" {
  network_watcher_name = azurerm_network_watcher.networkwatcher_hub.name
  resource_group_name  = azurerm_resource_group.rg_hub.name
  name                 = "hub-flow"

  target_resource_id = azurerm_virtual_network.hub_vnet.id
  storage_account_id = azurerm_storage_account.flow.id
  enabled            = true
  version            = 2

  retention_policy {
    enabled = true
    days    = 14
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