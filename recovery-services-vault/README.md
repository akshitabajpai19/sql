<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_validation"></a> [validation](#requirement\_validation) | ~> 1.1.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_avm_res_resources_resourcegroup"></a> [avm\_res\_resources\_resourcegroup](#module\_avm\_res\_resources\_resourcegroup) | ../resource-groups | n/a |
| <a name="module_diagnostics-setting-setup"></a> [diagnostics-setting-setup](#module\_diagnostics-setting-setup) | ../diagnostic-setting | n/a |
| <a name="module_private-endpoint-setup"></a> [private-endpoint-setup](#module\_private-endpoint-setup) | ../private-endpoint | n/a |
| <a name="module_role_assignments"></a> [role\_assignments](#module\_role\_assignments) | Azure/avm-res-authorization-roleassignment/azurerm | 0.1.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_backup_policy_file_share.file_share_backup_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_file_share) | resource |
| [azurerm_backup_policy_vm.vm_backup_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_vm) | resource |
| [azurerm_recovery_services_vault.vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault) | resource |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_key.kv_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_key) | data source |
| [azurerm_resource_group.rgrp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_user_assigned_identity.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_a_records"></a> [a\_records](#input\_a\_records) | A map of objects where each object contains information to create a A record. | <pre>map(object({<br>    name                = string<br>    resource_group_name = string<br>    zone_name           = string<br>    ttl                 = number<br>    records             = list(string)<br>    tags                = optional(map(string), null)<br>  }))</pre> | `{}` | no |
| <a name="input_aaaa_records"></a> [aaaa\_records](#input\_aaaa\_records) | A map of objects where each object contains information to create a AAAA record. | <pre>map(object({<br>    name                = string<br>    resource_group_name = string<br>    zone_name           = string<br>    ttl                 = number<br>    records             = list(string)<br>    tags                = optional(map(string), null)<br>  }))</pre> | `{}` | no |
| <a name="input_additionalcontext"></a> [additionalcontext](#input\_additionalcontext) | used for naming purposes such as 01 or 02 | `string` | `""` | no |
| <a name="input_appFunction"></a> [appFunction](#input\_appFunction) | app function | `string` | `""` | no |
| <a name="input_appid"></a> [appid](#input\_appid) | The related application for resources. Used for tagging and naming purposes. | `string` | `""` | no |
| <a name="input_appname"></a> [appname](#input\_appname) | the app name for the resources.  Used for tagging and naming purposes | `string` | `""` | no |
| <a name="input_cname_records"></a> [cname\_records](#input\_cname\_records) | A map of objects where each object contains information to create a CNAME record. | <pre>map(object({<br>    name                = string<br>    resource_group_name = string<br>    zone_name           = string<br>    ttl                 = number<br>    record              = string<br>    tags                = optional(map(string), null)<br>  }))</pre> | `{}` | no |
| <a name="input_costAllocation"></a> [costAllocation](#input\_costAllocation) | can only be sharedcosts or chargeback | `string` | `""` | no |
| <a name="input_costAppOwnerManager"></a> [costAppOwnerManager](#input\_costAppOwnerManager) | The app owner manager responsible for resources. Used for tagging purposes. | `string` | `""` | no |
| <a name="input_costAppOwnerTech"></a> [costAppOwnerTech](#input\_costAppOwnerTech) | The app owner responsible for resources. Used for tagging and naming purposes. | `string` | `""` | no |
| <a name="input_costBudgetOwner"></a> [costBudgetOwner](#input\_costBudgetOwner) | The budget owner responsible for resources. Used for tagging purposes. | `string` | `""` | no |
| <a name="input_costCostCenter"></a> [costCostCenter](#input\_costCostCenter) | The cost center code for resources. Used for tagging and naming purposes. | `string` | `""` | no |
| <a name="input_costDivision"></a> [costDivision](#input\_costDivision) | cost division | `string` | `""` | no |
| <a name="input_costVP"></a> [costVP](#input\_costVP) | The cost vp for resources. Used for tagging purposes. | `string` | `""` | no |
| <a name="input_costbaseline"></a> [costbaseline](#input\_costbaseline) | year resource created | `string` | `""` | no |
| <a name="input_create_dns_zone"></a> [create\_dns\_zone](#input\_create\_dns\_zone) | choose if DNS zone should be created or not | `bool` | `false` | no |
| <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group) | Set this to true if a new RG is required. | `bool` | `false` | no |
| <a name="input_diagnostics_settings_name"></a> [diagnostics\_settings\_name](#input\_diagnostics\_settings\_name) | The diagnostics setting name of the resource on. | `string` | n/a | yes |
| <a name="input_dns_zone_id"></a> [dns\_zone\_id](#input\_dns\_zone\_id) | The ID of the DNS zone if provided by the user | `string` | `""` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The name of the private dns zone. | `string` | n/a | yes |
| <a name="input_enable_diagnostic_setting"></a> [enable\_diagnostic\_setting](#input\_enable\_diagnostic\_setting) | Choose if Diagnostic setting should be enabled | `bool` | `true` | no |
| <a name="input_enable_encryption"></a> [enable\_encryption](#input\_enable\_encryption) | Variable to define if encryption in recovery vault should be enabled or not | `bool` | `false` | no |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | Variable to define if private endpoint should be enabled or not | `bool` | `false` | no |
| <a name="input_enable_telemetry"></a> [enable\_telemetry](#input\_enable\_telemetry) | This variable controls whether or not telemetry is enabled for the module.<br>For more information see https://aka.ms/avm/telemetryinfo.<br>If it is set to false, then no telemetry will be collected. | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | The environment code the for resources. Used for tagging and naming purposes. | `string` | `""` | no |
| <a name="input_excluded_log_categories"></a> [excluded\_log\_categories](#input\_excluded\_log\_categories) | List of log categories to exclude. | `list(string)` | `[]` | no |
| <a name="input_existing_user_assigned_identity_name"></a> [existing\_user\_assigned\_identity\_name](#input\_existing\_user\_assigned\_identity\_name) | Provide existing user assigned identity name | `string` | `null` | no |
| <a name="input_file_share_backup_policies"></a> [file\_share\_backup\_policies](#input\_file\_share\_backup\_policies) | A list of backup policies for file shares. | <pre>map(object({<br>    name      = string<br>    timezone  = string<br>    frequency = string<br>    time      = string<br>    daily = optional(list(object({<br>      count = number<br>    })), [])<br>    weekly = optional(list(object({<br>      count    = number<br>      weekdays = set(string)<br>    })), [])<br>    monthly = optional(list(object({<br>      count             = number<br>      weekdays          = optional(set(string))<br>      weeks             = optional(set(string))<br>      days              = optional(set(number))<br>      include_last_days = optional(bool)<br>    })), [])<br>    yearly = optional(list(object({<br>      count             = number<br>      weekdays          = optional(set(string))<br>      weeks             = optional(set(string))<br>      months            = optional(set(string))<br>      days              = optional(set(number))<br>      include_last_days = optional(bool)<br>    })), [])<br>  }))</pre> | `{}` | no |
| <a name="input_infrastructure_encryption_enabled"></a> [infrastructure\_encryption\_enabled](#input\_infrastructure\_encryption\_enabled) | Choose if infra encryption should be enabled | `bool` | `false` | no |
| <a name="input_key_vault_key_name"></a> [key\_vault\_key\_name](#input\_key\_vault\_key\_name) | Provide Keyvault key name | `string` | `null` | no |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | Provide Keyvault name | `string` | `null` | no |
| <a name="input_key_vault_rg_name"></a> [key\_vault\_rg\_name](#input\_key\_vault\_rg\_name) | Provide Keyvault RG name | `string` | `null` | no |
| <a name="input_kv_role_definition"></a> [kv\_role\_definition](#input\_kv\_role\_definition) | n/a | `string` | `"Key Vault Crypto Service Encryption User"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table' | `string` | `null` | no |
| <a name="input_lock"></a> [lock](#input\_lock) | Controls the Resource Lock configuration for this resource. The following properties can be specified:<br><br>  - `kind` - (Required) The type of lock. Possible values are `\"CanNotDelete\"` and `\"ReadOnly\"`.<br>  - `name` - (Optional) The name of the lock. If not specified, a name will be generated based on the `kind` value. Changing this forces the creation of a new resource. | <pre>object({<br>    kind = string<br>    name = optional(string, null)<br>  })</pre> | `null` | no |
| <a name="input_log_analytics_destination_type"></a> [log\_analytics\_destination\_type](#input\_log\_analytics\_destination\_type) | When set to 'Dedicated' logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table. | `string` | `"AzureDiagnostics"` | no |
| <a name="input_log_categories"></a> [log\_categories](#input\_log\_categories) | List of log categories. Defaults to all available. | `list(string)` | `null` | no |
| <a name="input_logs_destinations_ids"></a> [logs\_destinations\_ids](#input\_logs\_destinations\_ids) | List of destination resources IDs for logs diagnostic destination.<br>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br>If you want to use Azure EventHub as destination, you must provide a formatted string with both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the <code>&#124;</code> character. | `list(string)` | n/a | yes |
| <a name="input_managed_by"></a> [managed\_by](#input\_managed\_by) | resource group is managed by | `string` | `null` | no |
| <a name="input_metric_categories"></a> [metric\_categories](#input\_metric\_categories) | List of metric categories. Defaults to all available. | `list(string)` | `null` | no |
| <a name="input_monthlyBudget"></a> [monthlyBudget](#input\_monthlyBudget) | monthly budget | `string` | `""` | no |
| <a name="input_mx_records"></a> [mx\_records](#input\_mx\_records) | A map of objects where each object contains information to create a MX record. | <pre>map(object({<br>    name                = optional(string, "@")<br>    resource_group_name = string<br>    zone_name           = string<br>    ttl                 = number<br>    records = map(object({<br>      preference = number<br>      exchange   = string<br>    }))<br>    tags = optional(map(string), null)<br>  }))</pre> | `{}` | no |
| <a name="input_pe_subnet_name"></a> [pe\_subnet\_name](#input\_pe\_subnet\_name) | The Subnet name attached to private endpoint | `string` | n/a | yes |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | Private Endpoints for the supported resources | <pre>map(object({<br>    name                           = string<br>    private_connection_resource_id = string<br>    is_manual_connection           = optional(bool)<br>    subresource_names              = list(string)<br>    request_message                = optional(string)<br>    private_dns_zone_group_name    = optional(string)<br>    private_dns_zone_ids           = optional(list(string))<br>  }))</pre> | `{}` | no |
| <a name="input_ptr_records"></a> [ptr\_records](#input\_ptr\_records) | A map of objects where each object contains information to create a PTR record. | <pre>map(object({<br>    name                = string<br>    resource_group_name = string<br>    zone_name           = string<br>    ttl                 = number<br>    records             = list(string)<br>    tags                = optional(map(string), null)<br>  }))</pre> | `{}` | no |
| <a name="input_recovery_services_vault_name"></a> [recovery\_services\_vault\_name](#input\_recovery\_services\_vault\_name) | Name of the Recovery Services Vault to be created | `string` | n/a | yes |
| <a name="input_recovery_vault_cross_region_restore_enabled"></a> [recovery\_vault\_cross\_region\_restore\_enabled](#input\_recovery\_vault\_cross\_region\_restore\_enabled) | Is cross region restore enabled for this Vault? Only can be `true`, when `storage_mode_type` is `GeoRedundant`. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_recovery_vault_identity_type"></a> [recovery\_vault\_identity\_type](#input\_recovery\_vault\_identity\_type) | Azure Recovery Vault identity type. Possible values include: `null`, `SystemAssigned`. Default to `SystemAssigned`. | `string` | `null` | no |
| <a name="input_recovery_vault_immutability"></a> [recovery\_vault\_immutability](#input\_recovery\_vault\_immutability) | Immutability Settings of vault, possible values include: Locked, Unlocked and Disabled. | `string` | `"Disabled"` | no |
| <a name="input_recovery_vault_public_access_enabled"></a> [recovery\_vault\_public\_access\_enabled](#input\_recovery\_vault\_public\_access\_enabled) | Choose if Recovery vault public access should be enabled | `bool` | `false` | no |
| <a name="input_recovery_vault_sku"></a> [recovery\_vault\_sku](#input\_recovery\_vault\_sku) | Azure Recovery Vault SKU. Possible values include: `Standard`, `RS0`. Default to `Standard`. | `string` | `"Standard"` | no |
| <a name="input_recovery_vault_soft_delete_enabled"></a> [recovery\_vault\_soft\_delete\_enabled](#input\_recovery\_vault\_soft\_delete\_enabled) | Is soft delete enable for this Vault? Defaults to `true`. | `bool` | `true` | no |
| <a name="input_recovery_vault_storage_mode_type"></a> [recovery\_vault\_storage\_mode\_type](#input\_recovery\_vault\_storage\_mode\_type) | The storage type of the Recovery Services Vault. Possible values are `GeoRedundant`, `LocallyRedundant` and `ZoneRedundant`. Defaults to `GeoRedundant`. | `string` | `"LocallyRedundant"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | A container that holds related resources for an Azure solution | `string` | `null` | no |
| <a name="input_resourcetype"></a> [resourcetype](#input\_resourcetype) | the resource type being deployed see naming standards for example | `string` | `""` | no |
| <a name="input_rg_role_assignments"></a> [rg\_role\_assignments](#input\_rg\_role\_assignments) | The role assignment to be assigned to the resource group | <pre>map(object({<br>    role_definition_id_or_name             = string<br>    principal_id                           = string<br>    description                            = optional(string, null)<br>    skip_service_principal_aad_check       = optional(bool, false)<br>    condition                              = optional(string, null)<br>    condition_version                      = optional(string, null)<br>    delegated_managed_identity_resource_id = optional(string, null)<br>    principal_type                         = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_role_assignments_for_resources"></a> [role\_assignments\_for\_resources](#input\_role\_assignments\_for\_resources) | Define necessary role assignments for resources | <pre>map(object({<br>    resource_name       = string<br>    resource_group_name = string<br>    role_assignments = map(object({<br>      role_definition                    = string<br>      users                              = optional(set(string), [])<br>      groups                             = optional(set(string), [])<br>      app_registrations                  = optional(set(string), [])<br>      system_assigned_managed_identities = optional(set(string), [])<br>      user_assigned_managed_identities   = optional(set(string), [])<br>      any_principals                     = optional(set(string), [])<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_role_definitions"></a> [role\_definitions](#input\_role\_definitions) | Define the required role definition | <pre>map(object({<br>    id    = optional(string)<br>    name  = optional(string)<br>    scope = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_soa_record"></a> [soa\_record](#input\_soa\_record) | optional soa\_record variable, if included only email is required, rest are optional. Email must use username.corp.com and not username@corp.com | <pre>object({<br>    email        = string<br>    expire_time  = optional(number, 2419200)<br>    minimum_ttl  = optional(number, 10)<br>    refresh_time = optional(number, 3600)<br>    retry_time   = optional(number, 300)<br>    ttl          = optional(number, 3600)<br>    tags         = optional(map(string), null)<br>  })</pre> | `null` | no |
| <a name="input_srv_records"></a> [srv\_records](#input\_srv\_records) | A map of objects where each object contains information to create a SRV record. | <pre>map(object({<br>    name                = string<br>    resource_group_name = string<br>    zone_name           = string<br>    ttl                 = number<br>    records = map(object({<br>      priority = number<br>      weight   = number<br>      port     = number<br>      target   = string<br>    }))<br>    tags = optional(map(string), null)<br>  }))</pre> | `{}` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The Subscription ID | `string` | n/a | yes |
| <a name="input_system_assigned_managed_identities_by_principal_id"></a> [system\_assigned\_managed\_identities\_by\_principal\_id](#input\_system\_assigned\_managed\_identities\_by\_principal\_id) | Define system assigned managed identity details | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags of the resource. | `map(string)` | `null` | no |
| <a name="input_txt_records"></a> [txt\_records](#input\_txt\_records) | A map of objects where each object contains information to create a TXT record. | <pre>map(object({<br>    name                = string<br>    resource_group_name = string<br>    zone_name           = string<br>    ttl                 = number<br>    records = map(object({<br>      value = string<br>    }))<br>    tags = optional(map(string), null)<br>  }))</pre> | `{}` | no |
| <a name="input_user_assigned_identity_rg_name"></a> [user\_assigned\_identity\_rg\_name](#input\_user\_assigned\_identity\_rg\_name) | Provide existing user assigned identity RG name | `string` | `null` | no |
| <a name="input_user_assigned_managed_identities_by_resource_group_and_name"></a> [user\_assigned\_managed\_identities\_by\_resource\_group\_and\_name](#input\_user\_assigned\_managed\_identities\_by\_resource\_group\_and\_name) | Define user assigned managed identity details | <pre>map(object({<br>    resource_group_name = string<br>    name                = string<br>  }))</pre> | `{}` | no |
| <a name="input_virtual_network_links"></a> [virtual\_network\_links](#input\_virtual\_network\_links) | A map of objects where each object contains information to create a virtual network link. | <pre>map(object({<br>    vnetlinkname     = string<br>    vnetid           = string<br>    autoregistration = optional(bool, false)<br>    tags             = optional(map(string), null)<br>  }))</pre> | `{}` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | The VNET name attached to private endpoint | `string` | n/a | yes |
| <a name="input_virtual_network_rg"></a> [virtual\_network\_rg](#input\_virtual\_network\_rg) | The VNET RG name attached to private endpoint | `string` | n/a | yes |
| <a name="input_vm_backup_policies"></a> [vm\_backup\_policies](#input\_vm\_backup\_policies) | A list of backup policies for VMs. | <pre>map(object({<br>    name                           = string<br>    policy_type                    = string<br>    timezone                       = string<br>    instant_restore_retention_days = optional(number)<br>    frequency                      = string<br>    time                           = string<br>    hour_interval                  = optional(number)<br>    hour_duration                  = optional(number)<br>    weekdays                       = optional(set(string))<br>    daily = optional(list(object({<br>      count = number<br>    })), [])<br>    weekly = optional(list(object({<br>      count    = number<br>      weekdays = optional(set(string))<br>    })), [])<br>    monthly = optional(list(object({<br>      count             = number<br>      weekdays          = optional(set(string))<br>      weeks             = optional(set(string))<br>      days              = optional(set(number))<br>      include_last_days = optional(bool)<br>    })), [])<br>    yearly = optional(list(object({<br>      count             = number<br>      weekdays          = optional(set(string))<br>      weeks             = optional(set(string))<br>      months            = optional(set(string))<br>      days              = optional(set(number))<br>      include_last_days = optional(bool)<br>    })), [])<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_recovery_vault_id"></a> [recovery\_vault\_id](#output\_recovery\_vault\_id) | Azure Recovery Services Vault ID |
| <a name="output_recovery_vault_name"></a> [recovery\_vault\_name](#output\_recovery\_vault\_name) | Azure Recovery Services Vault name |
<!-- END_TF_DOCS -->

## Example Usage

```hcl
module "example_private_dns" {
  source              = "path/to/module"

  # Required Inputs
  name         = "example.com"
  resource_group_name = "example-resource-group"
  location     = "EastUS"
  sku          = "Standard"

  # Optional Inputs
  tags             = var.tags
  immutability     = var.immutability
  .
  .
}
```


## Example Tfvars

```hcl
create_resource_group                = true
enable_telemetry                     = true
resource_group_name                  = "avmModuleTesting2"
location                             = "EastUS"
recovery_services_vault_name         = "testrecoveryvaulteus"
key_vault_name                       = "testkvLu110"
key_vault_rg_name                    = "test-rg18"
key_vault_key_name                   = "test-key"
kv_role_definition                   = "Key Vault Crypto Officer"
recovery_vault_public_access_enabled = false
enable_encryption                    = true
enable_private_endpoint              = true
recovery_vault_identity_type         = "SystemAssigned"
# user_assigned_identity_rg_name       = "test-rg18" ##Should be provided if the recovery_vault_identity_type = "UserAssigned"
# existing_user_assigned_identity_name = "testuseridentity046" ##Should be provided if the recovery_vault_identity_type = "UserAssigned"
vm_backup_policies = {
  "test-whg-db-bkp-01" = {
    name                           = "test-whg-db-bkp-01"
    policy_type                    = "V2"
    timezone                       = "Eastern Standard Time"
    instant_restore_retention_days = 5
    frequency                      = "Daily"
    time                           = "02:00"
    daily = [{
      count = 30
    }]
    weekly = [{
      count    = 4
      weekdays = ["Sunday"]
    }]
    monthly = [{
      count    = 6
      weekdays = ["Sunday"]
      weeks    = ["First"]
    }]
    yearly = [{
      count    = 1
      months   = ["January"]
      weekdays = ["Sunday"]
      weeks    = ["First"]
    }]
  }
}

private_endpoints = {
  "pe1" = {
    name                 = "private-endpoint-23"
    subresource_names    = ["AzureSiteRecovery"]
    is_manual_connection = false
  }
}
# Azure Subscription ID
subscription_id = ""

# Virtual Network Details
virtual_network_rg   = "test-rg18"
virtual_network_name = "testvnet58"
pe_subnet_name       = "default"
dns_zone_id          = ""
create_dns_zone      = true
tags = {
  Environment = "Development"
  Department  = "IT"
}
diagnostics_settings_name = "test-diag1"
domain_name               = "test.project.com"
logs_destinations_ids     = [""]
enable_diagnostic_setting = true
virtual_network_links = {
  "test-vnet-link" = {
    vnetlinkname = "test-vnet-link5"
    vnetid       = ""
  }
}

# Tag variable values
resourcetype        = "rsv"
appid               = "ap01"
appname             = "infra"
env                 = "dev"
costcostcenter      = "test"
costvp              = "VP"
costappownertech    = "owner"
costappownermanager = "Manager"
costbudgetowner     = "budget owner"
costdivision        = "IT"
appfunction         = "exmaple general Prod Subscription"
costbaseline        = "2024"
costallocation      = "sharedcost"
monthlybudget       = "1000"
managed_by          = "own"
additionalcontext   = "01"
```