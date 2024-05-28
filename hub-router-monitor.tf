resource "azurerm_network_watcher" "networkwatcher_hub" {
  name                = "network-watcher-hub"
  location            = azurerm_resource_group.rg_hub.location
  resource_group_name = azurerm_resource_group.rg_hub.name
  tags                = var.tags
}

resource "azurerm_virtual_machine_extension" "ubunturoutervm_networkwatcher" {
  name                       = "${var.hub_router_hostname}-networkwatcher"
  virtual_machine_id         = module.ubunturoutervm.id
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentLinux"
  type_handler_version       = "1.4"
  auto_upgrade_minor_version = true
  tags                       = var.tags
}

resource "azurerm_network_connection_monitor" "ubunturoutervm_monitor_ubuntucom" {
  name               = "${var.hub_router_hostname}-ubuntucom"
  network_watcher_id = azurerm_network_watcher.networkwatcher_hub.id
  location           = azurerm_network_watcher.networkwatcher_hub.location
  tags               = var.tags

  endpoint {
    name               = var.hub_router_hostname
    target_resource_id = module.ubunturoutervm.id
  }

  endpoint {
    name    = "archive.ubuntu.com"
    address = "archive.ubuntu.com"
  }

  test_configuration {
    name                      = "tcp_80"
    protocol                  = "Tcp"
    test_frequency_in_seconds = 60

    tcp_configuration {
      port = 80
    }
  }

  test_group {
    name                     = "ubunturoutervm"
    destination_endpoints    = ["archive.ubuntu.com"]
    source_endpoints         = [var.hub_router_hostname]
    test_configuration_names = ["tcp_80"]
  }

  notes = "ubunturoutervm-ubuntucom"

  output_workspace_resource_ids = [azurerm_log_analytics_workspace.law_platform.id]

  depends_on = [azurerm_virtual_machine_extension.ubunturoutervm_networkwatcher]
}