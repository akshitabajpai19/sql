<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.6, < 1.9.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.71.0, <= 4.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.71.0, <= 4.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_private_dns_zone"></a> [private-dns-zone](#module\_private-dns-zone) | ../private-dns-zone | n/a |


## Resources

| Name | Type |
|------|------|
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table' | `string` | `null` | yes |
| <a name="input_private_dns_zone_group_name"></a> [private\_dns\_zone\_group\_name](#input\_private\_dns\_zone\_group\_name) | n/a | `string` | `"default"` | no |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | n/a | `list(string)` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | A container that holds related resources for an Azure solution | `string` | `null` | no |
| <a name="input_subresource_names"></a> [subresource\_names](#input\_subresource\_names) | Possible values are AzureBackup, AzureSiteRecovery. | `list(string)` | <pre>[<br>  "AzureBackup"<br>]</pre> | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | `{}` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | n/a | `string` | `null` | no |
| <a name="input_virtual_network_rg"></a> [virtual\_network\_rg](#input\_virtual\_network\_rg) | n/a | `string` | `null` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | Private Endpoints for the supported resources | <pre>map(object({<br>    name                           = string<br>    private_connection_resource_id = string<br>    is_manual_connection           = optional(string)<br>    subresource_names              = list(string)<br>    request_message                = optional(string)<br>    private_dns_zone_group_name    = optional(string)<br>    private_dns_zone_ids           = optional(list(string))<br>  }))</pre> | `{}` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\domain\_name) | n/a | `string` | `null` | no |
| <a name="input_a_records"></a> [a\_records](#input\_a\_records) | A map of objects where each object contains information to create a A record. | <pre>map(object({<br>    name                           = string<br>    resource_group_name            = string<br>    zone_name                      = string<br>    ttl                            = number<br>    records                        = list(string)<br>    tags                           = optional(map(string), null)  <br>    }))</pre> | `{}` | no |
| <a name="input_aaaa_records"></a> [aaaa\_records](#input\_aaaa\_records) | A map of objects where each object contains information to create a AAAA record. | <pre>map(object({<br>    name                           = string<br>    resource_group_name            = string<br>    zone_name                      = string<br>    ttl                            = number<br>    records                        = list(string)<br>    tags                           = optional(map(string), null)  <br>    }))</pre> | `{}` | no |
| <a name="input_cname_records"></a> [cname\_records](#input\_cname\_records) | A map of objects where each object contains information to create a CNAME record. | <pre>map(object({<br>    name                           = string<br>    resource_group_name            = string<br>    zone_name                      = string<br>    ttl                            = number<br>    records                        = string<br>    tags                           = optional(map(string), null)  <br>    }))</pre> | `{}` | no |
| <a name="input_enable_telemetry"></a> [enable\_telemetry](#input\_enable\_telemetry) | This variable controls whether or not telemetry is enabled for the module.For more information see https://aka.ms/avm/telemetryinfo.If it is set to false, then no telemetry will be collected. | `bool` | `true` | no |
| <a name="input_mx_records"></a> [mx\_records](#input\_mx\_records) | A map of objects where each object contains information to create a MX record. | <pre>map(object({<br>    name                           = optional(string, "@")<br>    resource_group_name            = string<br>    zone_name                      = string<br>    ttl                            = number<br>    records                        = map(object({<br>    preference         = number<br>     exchange           = string<br>}))tags                           = optional(map(string), null)  <br>    }))</pre> | `{}` | no |
| <a name="input_ptr_records"></a> [ptr\_records](#input\_ptr\_records) | A map of objects where each object contains information to create a PTR record. | <pre>map(object({<br>    name                           = string<br>    resource_group_name            = string<br>    zone_name                      = string<br>    ttl                            = number<br>    records                        = list(string)<br>    tags                           = optional(map(string), null)<br>    }))</pre> | `{}` | no |
| <a name="input_soa_records"></a> [soa\_records](#input\_soa\_records) | optional soa_record variable, if included only email is required, rest are optional. Email must use username.corp.com and not username@corp.com | <pre>map(object({<br>    email                           = string<br>    expire_time                     = optional(number, 2419200)<br>    minimum_ttl                     = optional(number, 10)<br>     refresh_time                    = optional(number, 3600)<br>     retry_time                      = optional(number, 300)<br>    ttl                             = optional(number, 3600)<br>   tags                            = optional(map(string), null)  <br>    }))</pre> | `{}` | no |
| <a name="input_srv_records"></a> [srv\_records](#input\_srv\_records) | A map of objects where each object contains information to create a SRV record. | <pre>map(object({<br>    name                           = string<br>    resource_group_name            = string<br>    zone_name                      = string<br>    ttl                            = number<br>    records                        = map(object({<br>  priority         = number<br>  weight           = number<br>  port             = number<br>  target           = string}))<br>   tags                           = optional(map(string), null)  <br>    }))</pre> | `{}` | no |
| <a name="input_txt_records"></a> [txt\_records](#input\_txt\_records) | A map of objects where each object contains information to create a TXT record. | <pre>map(object({<br>    name                           = string<br>    resource_group_name            = string<br>    zone_name                      = string<br>    ttl                            = number<br>    records                        = map(object({<br>  value         = string<br> }))tags                           = optional(map(string), null)  <br>    }))</pre> | `{}` | no |
| <a name="input_virtual_network_links"></a> [virtual\_network\_links](#input\_virtual\_network\_links) | A map of objects where each object contains information to create a virtual network link. | <pre>map(object({<br>    vnetlinkname               = string<br>    vnetid                     = string<br>  autoregistration           = optional(bool, false)<br>    tags                       = optional(map(string), null)  <br>    }))</pre> | `{}` | no |
| <a name="input_private_connection_resource_id"></a> [dns\_zone\_id](#input\_private\_connection\_resource\_id) | n/a | `string` | `null` | yes |
| <a name="input_dns_zone_id"></a> [dns\_zone\_id](#input\_dns\_zone\_id) | n/a | `string` | `null` | no |
| <a name="input_create_dns_zone"></a> [create\_dns\_zone](#input\create\_dns\_zone) | choose if DNS zone should be created or not | `bool` | `true` | no |
| <a name="input_resourcetype"></a> [resourcetype](#input\_resourcetype) | the resource type being deployed see naming standards for example | `string` | `null` | no |
| <a name="input_appid"></a> [appid](#input\_appid) | The related application for resources. Used for tagging and naming purposes. | `string` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | The environment code the for resources.  Used for tagging and naming purposes | `string` | `null` | no |
| <a name="input_appname"></a> [appname](#input\_appname) | the app name for the resources.  Used for tagging and naming purposes | `string` | `null` | no |
| <a name="input_costCostCenter"></a> [costCostCenter](#input\_costCostCenter) | The cost center code for resources.  Used for tagging and naming purposes | `string` | `null` | no |
| <a name="input_costVP"></a> [costVP](#input\_costVP) | The cost vp for resources.  Used for tagging and naming purposes | `string` | `null` | no |
| <a name="input_costAppOwnerTech"></a> [costAppOwnerTech](#input\_costAppOwnerTech) | The app owner responsible for resources. Used for tagging and naming purposes | `string` | `null` | no |
| <a name="input_costAppOwnerManager"></a> [costAppOwnerManager](#input\_costAppOwnerManager) | The app owner manager responsible for resources. Used for tagging and naming purposes | `string` | `null` | no |
| <a name="input_costBudgetOwner"></a> [costBudgetOwner](#input\_costBudgetOwner) | The budget owner responsible for resources. Used for tagging and naming purposes | `string` | `null` | no |
| <a name="input_additionalcontext"></a> [additionalcontext](#input\_additionalcontext) | used for naming purposes such as 01 or 02 | `string` | `null` | no |
| <a name="input_costDivision"></a> [costDivision](#input\_costDivision) | cost division | `string` | `null` | no |
| <a name="input_costAllocation"></a> [costAllocation](#input\_costAllocation) | can only be sharedcosts or chargeback | `string` | `null` | no |
| <a name="input_appFunction"></a> [appFunction](#input\_appFunction) | app function | `string` | `null` | no |
| <a name="input_monthlyBudget"></a> [monthlyBudget](#input\_monthlyBudget) | monthly budget | `string` | `null` | no |
| <a name="input_costbaseline"></a> [costbaseline](#input\_costbaseline) | year resource created | `string` | `null` | no |


## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Example Usage

```hcl
resource "azurerm_private_endpoint" "this" {
  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = ""

  private_service_connection {}
  .
  .
}
```


## Example Tfvars

```hcl
create_resource_group   = true
enable_telemetry        = true
resource_group_name     = "avmModuleTesting2"
location                = "EastUS"
enable_private_endpoint = true

private_endpoints = {
  "pe1" = {
    name                        = "private-endpoint-23"
    subresource_names           = ["Blob"]
    is_manual_connection        = false
    private_dns_zone_group_name = "my-private-dns-zone-group1"
  }
}
private_connection_resource_id = ""
# Azure Subscription ID
subscription_id = ""

# Virtual Network Details
virtual_network_rg   = "test-lumen-rg13"
virtual_network_name = "testvnet48"
pe_subnet_name       = "default"
dns_zone_id          = ""
create_dns_zone      = true
domain_name          = "test.project.com"
additionalcontext    = "test"
virtual_network_links = {
  "test-vnet-link" = {
    vnetlinkname = "test-vnet-link2"
    vnetid       = ""
  }
}

# Tag variable values
resourcetype   = "sub"
appid          = "test"
appname        = "exmaple-infra"
env            = "dev"
costCostCenter = "test"
# costVP                               = "vp"
costAppOwnerTech    = "owner"
costAppOwnerManager = "manager"
costBudgetOwner     = "budget owner"
# management_group_name                = "mg-name"
# costDivision                         = "devision-name"
appFunction    = "exmaple general dev Subscription"
costbaseline   = "2024"
costAllocation = "sharedcost"
monthlyBudget  = "1000"
```