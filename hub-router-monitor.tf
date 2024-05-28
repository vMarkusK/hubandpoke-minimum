resource "azurerm_virtual_machine_extension" "ubunturoutervm_networkwatcher" {
  name                       = "${var.hub_router_hostname}-NetworkWatcher"
  virtual_machine_id         = module.ubunturoutervm.id
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentLinux"
  type_handler_version       = "1.4"
  auto_upgrade_minor_version = true
}