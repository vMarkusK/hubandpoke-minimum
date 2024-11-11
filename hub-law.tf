resource "azurerm_log_analytics_workspace" "law_platform" {
  name                = "law-platform"
  location            = azurerm_resource_group.rg_hub.location
  resource_group_name = azurerm_resource_group.rg_hub.name
  sku                 = "PerGB2018"
  tags                = var.tags
}

data "azurerm_monitor_diagnostic_categories" "nsg_logs" {
  resource_id = azurerm_network_security_group.nsg-router.id
}

resource "azurerm_monitor_diagnostic_setting" "nsg_router" {
  name                       = "nsg_router_diag"
  target_resource_id         = azurerm_network_security_group.nsg-router.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law_platform.id

  dynamic "enabled_log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.nsg_logs.log_category_types
    content {
      category = entry.value
    }
  }

  dynamic "metric" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.nsg_logs.metrics
    content {
      category = entry.value
      enabled  = true
    }
  }

}
