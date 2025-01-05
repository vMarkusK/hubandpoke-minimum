data "template_file" "cloudconfig_linux" {
  template = var.router ? ("${path.module}/cloudconfig_linux_router.tpl") : ("${path.module}/cloudconfig_linux.tpl")
}

data "template_cloudinit_config" "config_linux" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = data.template_file.cloudconfig_linux.rendered
  }
}

# PIP
resource "random_id" "randomid_pip" {
  count = var.router ? 1 : 0

  byte_length = 4
}

resource "azurerm_public_ip" "pip_spokevmnic" {
  count = var.router ? 1 : 0

  name                = "pip-${var.vmname}"
  resource_group_name = var.rgname
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "pip-${random_id.randomid_pip[0].hex}"
  tags                = var.tags
}

# Create network interface
resource "azurerm_network_interface" "spokevmnic" {
  name                  = "nic-${var.vmname}-${random_id.randomIdVM.hex}"
  location              = var.location
  resource_group_name   = var.rgname
  ip_forwarding_enabled = var.router

  ip_configuration {
    name                          = "${var.vmname}-ipconfig1"
    subnet_id                     = var.subnetid
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.router ? azurerm_public_ip.pip_spokevmnic[0].id : null
  }

  tags = var.tags
}

# Generate random text for a unique storage account name and DNS label
resource "random_id" "randomId" {
  count = var.bootdiagnostics ? 1 : 0

  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = var.rgname
  }
  byte_length = 8
}
resource "random_id" "randomIdVM" {
  byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "spokestorageaccount" {
  count = var.bootdiagnostics ? 1 : 0

  name                     = "diag${random_id.randomI[0].hex}"
  resource_group_name      = var.rgname
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  network_rules {
    default_action = "Deny"
    ip_rules       = ["51.116.75.88", "20.52.95.48", "51.12.72.223", "51.12.22.174"] #IPs from Germany and Sweden 
    bypass         = ["Logging", "Metrics", "AzureServices"]
  }

  sas_policy {
    expiration_period = "90.00:00:00"
    expiration_action = "Log"
  }

  tags = var.tags
}

# Create virtual machine
#trivy:ignore:AVD-AZU-0039
resource "azurerm_linux_virtual_machine" "spokevm" {
  name                = var.vmname
  location            = var.location
  resource_group_name = var.rgname
  size                = var.vmsize
  computer_name       = var.vmname

  admin_username                  = var.adminusername
  admin_password                  = var.vmpassword
  disable_password_authentication = false

  patch_mode         = "AutomaticByPlatform"
  provision_vm_agent = true

  custom_data = data.template_cloudinit_config.config_linux.rendered

  network_interface_ids = [
    azurerm_network_interface.spokevmnic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"

  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  dynamic "boot_diagnostics" {
    for_each = var.bootdiagnostics == true ? [1] : []
    content {
      storage_account_uri = azurerm_storage_account.spokestorageaccount[0].primary_blob_endpoint
    }
  }

  tags = var.tags
}
