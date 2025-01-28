# Azure Hub & Spoke Minimum

Azure Hub & Spoke Minimum Deployment with Pipeline.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.10.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.14.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.14.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.6.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_spoke1network"></a> [spoke1network](#module\_spoke1network) | ./modules/spokedefault | n/a |
| <a name="module_spoke2network"></a> [spoke2network](#module\_spoke2network) | ./modules/spokedefault | n/a |
| <a name="module_ubunturoutervm"></a> [ubunturoutervm](#module\_ubunturoutervm) | ./modules/ubuntuvm | n/a |
| <a name="module_ubuntuspoke1"></a> [ubuntuspoke1](#module\_ubuntuspoke1) | ./modules/ubuntuvm | n/a |
| <a name="module_ubuntuspoke2"></a> [ubuntuspoke2](#module\_ubuntuspoke2) | ./modules/ubuntuvm | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_workspace.law_platform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_monitor_diagnostic_setting.nsg_router](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_network_connection_monitor.spoke1vm_monitor_ubuntucom](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_connection_monitor) | resource |
| [azurerm_network_connection_monitor.spoke2vm_monitor_ubuntucom](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_connection_monitor) | resource |
| [azurerm_network_connection_monitor.ubunturoutervm_monitor_ubuntucom](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_connection_monitor) | resource |
| [azurerm_network_security_group.nsg_router](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_watcher.networkwatcher_hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher) | resource |
| [azurerm_network_watcher_flow_log.hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log) | resource |
| [azurerm_network_watcher_flow_log.spoke1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log) | resource |
| [azurerm_network_watcher_flow_log.spoke2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log) | resource |
| [azurerm_resource_group.rg_compute](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.flow](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_subnet.hub_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.nsg_router-association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_machine_extension.spoke1vm_networkwatcher](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.spoke2vm_networkwatcher](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.ubunturoutervm_networkwatcher](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_network.hub_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [random_id.id_flow](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [azurerm_key_vault.secrets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.vmpassword](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_monitor_diagnostic_categories.nsg_logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hub_rg_name"></a> [hub\_rg\_name](#input\_hub\_rg\_name) | Name of the Hub RG | `string` | n/a | yes |
| <a name="input_hub_router_hostname"></a> [hub\_router\_hostname](#input\_hub\_router\_hostname) | Hostname of Router VM | `string` | n/a | yes |
| <a name="input_hub_vnet_addressspace"></a> [hub\_vnet\_addressspace](#input\_hub\_vnet\_addressspace) | Address Space of the Hub VNet | `list(string)` | n/a | yes |
| <a name="input_hub_vnet_name"></a> [hub\_vnet\_name](#input\_hub\_vnet\_name) | Name of the Hub VNet | `string` | n/a | yes |
| <a name="input_hub_vnet_subnets"></a> [hub\_vnet\_subnets](#input\_hub\_vnet\_subnets) | Subnets of the Hub VNet | <pre>list(object({<br/>    name = string<br/>    cidr = list(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location for all resources | `string` | n/a | yes |
| <a name="input_myip"></a> [myip](#input\_myip) | My OnPrem IP to Access Router | `string` | n/a | yes |
| <a name="input_rg_compute_name"></a> [rg\_compute\_name](#input\_rg\_compute\_name) | Compute RG Name | `string` | n/a | yes |
| <a name="input_spoke1_address_space"></a> [spoke1\_address\_space](#input\_spoke1\_address\_space) | spoke1 Address Space | `string` | n/a | yes |
| <a name="input_spoke1_rg_name"></a> [spoke1\_rg\_name](#input\_spoke1\_rg\_name) | spoke1 RG name | `string` | n/a | yes |
| <a name="input_spoke1_vm_hostname"></a> [spoke1\_vm\_hostname](#input\_spoke1\_vm\_hostname) | Hostname of spoke1 VM | `string` | n/a | yes |
| <a name="input_spoke1_vnet_name"></a> [spoke1\_vnet\_name](#input\_spoke1\_vnet\_name) | spoke1 vnet name | `string` | n/a | yes |
| <a name="input_spoke1_vnet_subnets"></a> [spoke1\_vnet\_subnets](#input\_spoke1\_vnet\_subnets) | Subnets of the spoke1 VNet | <pre>list(object({<br/>    name                    = string<br/>    cidr                    = list(string)<br/>    outbound_access_enabled = bool<br/>  }))</pre> | n/a | yes |
| <a name="input_spoke2_address_space"></a> [spoke2\_address\_space](#input\_spoke2\_address\_space) | spoke2 Address Space | `string` | n/a | yes |
| <a name="input_spoke2_rg_name"></a> [spoke2\_rg\_name](#input\_spoke2\_rg\_name) | spoke2 RG name | `string` | n/a | yes |
| <a name="input_spoke2_vm_hostname"></a> [spoke2\_vm\_hostname](#input\_spoke2\_vm\_hostname) | Hostname of spoke1 VM | `string` | n/a | yes |
| <a name="input_spoke2_vnet_name"></a> [spoke2\_vnet\_name](#input\_spoke2\_vnet\_name) | spoke2 vnet name | `string` | n/a | yes |
| <a name="input_spoke2_vnet_subnets"></a> [spoke2\_vnet\_subnets](#input\_spoke2\_vnet\_subnets) | Subnets of the spoke2 VNet | <pre>list(object({<br/>    name                    = string<br/>    cidr                    = list(string)<br/>    outbound_access_enabled = bool<br/>  }))</pre> | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Subscription ID for all resources | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to associate with your network and subnets. | `map(string)` | n/a | yes |
| <a name="input_vm_admin_user"></a> [vm\_admin\_user](#input\_vm\_admin\_user) | Username for Virtual Machines | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Size of the VMs | `string` | n/a | yes |
| <a name="input_vm_size_router"></a> [vm\_size\_router](#input\_vm\_size\_router) | Size of the router VM | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_router_public_dns_fqdn"></a> [router\_public\_dns\_fqdn](#output\_router\_public\_dns\_fqdn) | n/a |
| <a name="output_router_public_ip"></a> [router\_public\_ip](#output\_router\_public\_ip) | n/a |
| <a name="output_router_vm_private_ip"></a> [router\_vm\_private\_ip](#output\_router\_vm\_private\_ip) | n/a |
| <a name="output_spoke1_vm_private_ip"></a> [spoke1\_vm\_private\_ip](#output\_spoke1\_vm\_private\_ip) | n/a |
| <a name="output_spoke2_vm_private_ip"></a> [spoke2\_vm\_private\_ip](#output\_spoke2\_vm\_private\_ip) | n/a |
| <a name="output_vm_username"></a> [vm\_username](#output\_vm\_username) | n/a |