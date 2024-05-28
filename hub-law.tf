resource "azurerm_log_analytics_workspace" "law_platform" {
  name                = "law-platform"
  location            = azurerm_resource_group.rg_hub.location
  resource_group_name = azurerm_resource_group.rg_hub.name
  sku                 = "PerGB2018"
  tags                = var.tags
}