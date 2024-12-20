#trivy:ignore:AVD-AZU-0049
resource "azurerm_network_watcher_flow_log" "spoke1" {
  network_watcher_name = azurerm_network_watcher.networkwatcher_hub.name
  resource_group_name  = azurerm_resource_group.rg_hub.name
  name                 = "spoke1-flow"

  target_resource_id = module.spoke1network.vnet_id
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