resource "azurerm_virtual_machine_extension" "spoke1vm_networkwatcher" {
  name                       = "${var.spoke1_vm_hostname}-networkwatcher"
  virtual_machine_id         = module.ubuntuspoke1.id
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentLinux"
  type_handler_version       = "1.4"
  auto_upgrade_minor_version = true
  tags                       = var.tags
}

resource "azurerm_network_connection_monitor" "spoke1vm_monitor_ubuntucom" {
  name               = "${var.spoke1_vm_hostname}-ubuntucom"
  network_watcher_id = azurerm_network_watcher.networkwatcher_hub.id
  location           = azurerm_network_watcher.networkwatcher_hub.location
  tags               = var.tags

  endpoint {
    name               = var.spoke1_vm_hostname
    target_resource_id = module.ubuntuspoke1.id
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
    name                     = "spoke1vm"
    destination_endpoints    = ["archive.ubuntu.com"]
    source_endpoints         = [var.spoke1_vm_hostname]
    test_configuration_names = ["tcp_80"]
  }

  notes = "spoke1vm-ubuntucom"

  output_workspace_resource_ids = [azurerm_log_analytics_workspace.law_platform.id]

  depends_on = [azurerm_virtual_machine_extension.spoke1vm_networkwatcher]
}