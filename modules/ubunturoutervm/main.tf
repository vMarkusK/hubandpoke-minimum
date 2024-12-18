data "template_file" "cloudconfig_linux" {
  template = file("${path.module}/${var.cloudconfig_file_linux}")
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
  byte_length = 4
}

resource "azurerm_public_ip" "pip_spokevmnic" {
  name                = "pip-${var.vmname}"
  resource_group_name = var.rgname
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "pip-${random_id.randomid_pip.hex}"
  tags                = var.tags
}

# Create network interface
resource "azurerm_network_interface" "spokevmnic" {
  name                  = "nic-${var.vmname}-${random_id.randomid_pip.hex}"
  location              = var.location
  resource_group_name   = var.rgname
  ip_forwarding_enabled = true

  ip_configuration {
    name                          = "${var.vmname}-ipconfig1"
    subnet_id                     = var.subnetid
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_spokevmnic.id
  }

  tags = var.tags
}

# Generate random text for a unique storage account name and DNS label
resource "random_id" "randomId" {
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
  name                     = "diag${random_id.randomId.hex}"
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

  tags = var.tags
}

# Create virtual machine
#trivy:ignore:AVD-AZU-0039
resource "azurerm_virtual_machine" "spokevm" {
  name                             = var.vmname
  location                         = var.location
  resource_group_name              = var.rgname
  network_interface_ids            = [azurerm_network_interface.spokevmnic.id]
  vm_size                          = var.vmsize
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_os_disk {
    name              = "${var.vmname}-myOsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.vmname
    admin_username = var.adminusername
    admin_password = var.vmpassword
    custom_data    = data.template_cloudinit_config.config_linux.rendered
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = azurerm_storage_account.spokestorageaccount.primary_blob_endpoint
  }

  tags = var.tags
}
