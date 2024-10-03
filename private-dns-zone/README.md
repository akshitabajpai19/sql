<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.6, < 2.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 3.6, <= 3.114.0)

- <a name="requirement_modtm"></a> [modtm](#requirement\_modtm) (~> 0.3)

- <a name="requirement_random"></a> [random](#requirement\_random) (>= 3.5.1, < 4.0)

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

The following resources are used by this module:

- [azurerm_private_dns_a_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) (resource)
- [azurerm_private_dns_aaaa_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_aaaa_record) (resource)
- [azurerm_private_dns_cname_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_cname_record) (resource)
- [azurerm_private_dns_mx_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_mx_record) (resource)
- [azurerm_private_dns_ptr_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_ptr_record) (resource)
- [azurerm_private_dns_srv_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_srv_record) (resource)
- [azurerm_private_dns_txt_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_txt_record) (resource)
- [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) (resource)
- [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) (resource)
- [modtm_telemetry.telemetry](https://registry.terraform.io/providers/azure/modtm/latest/docs/resources/telemetry) (resource)
- [random_uuid.telemetry](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) (resource)
- [azurerm_client_config.telemetry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) (data source)
- [modtm_module_source.telemetry](https://registry.terraform.io/providers/azure/modtm/latest/docs/data-sources/module_source) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name)

Description: The name of the private dns zone.

Type: `string`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: The resource group where the resources will be deployed.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

## Locals

### Only upto 15 tags should be added in local tags 

### <a name="input_additionalcontext"></a> [additionalcontext](#input\_additionalcontext)
Description: used for naming purposes such as 01 or 02 

Type: `string`

### <a name="input_appFunction"></a> [appFunction](#input\_appFunction)
Description: app function 

Type: `string`

### <a name="input_appid"></a> [appid](#input\_appid)
Description: The related application for resources. Used for tagging and naming purposes.

Type: `string`

### <a name="input_appname"></a> [appname](#input\_appname)
Description: the app name for the resources.  Used for tagging and naming purposes

Type: `string`

### <a name="input_costAllocation"></a> [costAllocation](#input\_costAllocation)
Description: can only be sharedcosts or chargeback

Type: `string`

### <a name="input_costAppOwnerManager"></a> [costAppOwnerManager](#input\_costAppOwnerManager)
Description: The app owner manager responsible for resources. Used for tagging purposes.

Type: `string`

### <a name="input_costAppOwnerTech"></a> [costAppOwnerTech](#input\_costAppOwnerTech) 
Description: The app owner responsible for resources. Used for tagging and naming purposes.

Type: `string`

###  <a name="input_costBudgetOwner"></a> [costBudgetOwner](#input\_costBudgetOwner) 
Description: The budget owner responsible for resources. Used for tagging purposes.

Type: `string`

###  <a name="input_costCostCenter"></a> [costCostCenter](#input\_costCostCenter)
Description: The cost center code for resources. Used for tagging and naming purposes.

Type: `string`

###  <a name="input_costDivision"></a> [costDivision](#input\_costDivision)
Description: cost division

Type: `string`

### <a name="input_costVP"></a> [costVP](#input\_costVP)
Description: The cost vp for resources. Used for tagging purposes.

Type: `string`

### <a name="input_costbaseline"></a> [costbaseline](#input\_costbaseline) 
Description:  year resource created 

Type: `string`

### <a name="input_env"></a> [env](#input\_env)
Description:  The environment code the for resources. Used for tagging and naming purposes.

Type: `string`

### <a name="input_location"></a> [location](#input\_location) 
Description:  The Azure region where resources will be deployed

Type: `string`

### <a name="input_monthlyBudget"></a> [monthlyBudget](#input\_monthlyBudget)
Description:  monthly budget

Type: `string`


### <a name="input_a_records"></a> [a\_records](#input\_a\_records)

Description: A map of objects where each object contains information to create a A record.

Type:

```hcl
map(object({
    name                = string
    resource_group_name = string
    zone_name           = string
    ttl                 = number
    records             = list(string)
    tags                = optional(map(string), null)
  }))
```

Default: `{}`

### <a name="input_aaaa_records"></a> [aaaa\_records](#input\_aaaa\_records)

Description: A map of objects where each object contains information to create a AAAA record.

Type:

```hcl
map(object({
    name                = string
    resource_group_name = string
    zone_name           = string
    ttl                 = number
    records             = list(string)
    tags                = optional(map(string), null)
  }))
```

Default: `{}`

### <a name="input_cname_records"></a> [cname\_records](#input\_cname\_records)

Description: A map of objects where each object contains information to create a CNAME record.

Type:

```hcl
map(object({
    name                = string
    resource_group_name = string
    zone_name           = string
    ttl                 = number
    record              = string
    tags                = optional(map(string), null)
  }))
```

Default: `{}`

### <a name="input_enable_telemetry"></a> [enable\_telemetry](#input\_enable\_telemetry)

Description: This variable controls whether or not telemetry is enabled for the module.  
For more information see https://aka.ms/avm/telemetryinfo.  
If it is set to false, then no telemetry will be collected.

Type: `bool`

Default: `true`

### <a name="input_mx_records"></a> [mx\_records](#input\_mx\_records)

Description: A map of objects where each object contains information to create a MX record.

Type:

```hcl
map(object({
    name                = optional(string, "@")
    resource_group_name = string
    zone_name           = string
    ttl                 = number
    records = map(object({
      preference = number
      exchange   = string
    }))
    tags = optional(map(string), null)
  }))
```

Default: `{}`

### <a name="input_ptr_records"></a> [ptr\_records](#input\_ptr\_records)

Description: A map of objects where each object contains information to create a PTR record.

Type:

```hcl
map(object({
    name                = string
    resource_group_name = string
    zone_name           = string
    ttl                 = number
    records             = list(string)
    tags                = optional(map(string), null)
  }))
```

Default: `{}`

### <a name="input_soa_record"></a> [soa\_record](#input\_soa\_record)

Description: optional soa\_record variable, if included only email is required, rest are optional. Email must use username.corp.com and not username@corp.com

Type:

```hcl
object({
    email        = string
    expire_time  = optional(number, 2419200)
    minimum_ttl  = optional(number, 10)
    refresh_time = optional(number, 3600)
    retry_time   = optional(number, 300)
    ttl          = optional(number, 3600)
    tags         = optional(map(string), null)
  })
```

Default: `null`

### <a name="input_srv_records"></a> [srv\_records](#input\_srv\_records)

Description: A map of objects where each object contains information to create a SRV record.

Type:

```hcl
map(object({
    name                = string
    resource_group_name = string
    zone_name           = string
    ttl                 = number
    records = map(object({
      priority = number
      weight   = number
      port     = number
      target   = string
    }))
    tags = optional(map(string), null)
  }))
```

Default: `{}`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: (Optional) Tags of the resource.

Type: `map(string)`

Default: `null`

### <a name="input_txt_records"></a> [txt\_records](#input\_txt\_records)

Description: A map of objects where each object contains information to create a TXT record.

Type:

```hcl
map(object({
    name                = string
    resource_group_name = string
    zone_name           = string
    ttl                 = number
    records = map(object({
      value = string
    }))
    tags = optional(map(string), null)
  }))
```

Default: `{}`

### <a name="input_virtual_network_links"></a> [virtual\_network\_links](#input\_virtual\_network\_links)

Description: A map of objects where each object contains information to create a virtual network link.

Type:

```hcl
map(object({
    vnetlinkname     = string
    vnetid           = string
    autoregistration = optional(bool, false)
    tags             = optional(map(string), null)
  }))
```

Default: `{}`


## Outputs

The following outputs are exported:

### <a name="output_a_record_outputs"></a> [a\_record\_outputs](#output\_a\_record\_outputs)

Description: The a record output

### <a name="output_aaaa_record_outputs"></a> [aaaa\_record\_outputs](#output\_aaaa\_record\_outputs)

Description: The aaaa record output

### <a name="output_cname_record_outputs"></a> [cname\_record\_outputs](#output\_cname\_record\_outputs)

Description: The cname record output

### <a name="output_mx_record_outputs"></a> [mx\_record\_outputs](#output\_mx\_record\_outputs)

Description: The mx record output

### <a name="output_name"></a> [name](#output\_name)

Description: The name of private DNS zone

### <a name="output_ptr_record_outputs"></a> [ptr\_record\_outputs](#output\_ptr\_record\_outputs)

Description: The ptr record output

### <a name="output_resource"></a> [resource](#output\_resource)

Description: The private dns zone output

### <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id)

Description: The resource id of private DNS zone

### <a name="output_srv_record_outputs"></a> [srv\_record\_outputs](#output\_srv\_record\_outputs)

Description: The srv record output

### <a name="output_txt_record_outputs"></a> [txt\_record\_outputs](#output\_txt\_record\_outputs)

Description: The txt record output

### <a name="output_virtual_network_link_outputs"></a> [virtual\_network\_link\_outputs](#output\_virtual\_network\_link\_outputs)

Description: The virtual network link output

## Example Usage

```hcl
module "example_private_dns" {
  source              = "path/to/module"

  # Required Inputs
  domain_name         = "example.com"
  resource_group_name = "example-resource-group"

  # Optional Inputs
  a_records             = var.a_records
  aaaa_records          = var.aaaa_records
  .
  .
}
```

## Example Tfvars

```hcl
# local
appname                = "myapp"
env                    = "prod"
appid                  = "12345"
resourcetype           = "dns"
costAppOwnerManager    = "owner-manager@example003.com"
costAppOwnerTech       = "owner-tech@example003.com"
costBudgetOwner        = "budget-owner@example003.com"
costCostCenter         = "center-1"
costRegion             = "us-west"
costAllocation         = "sharedcosts"  # Can be "sharedcosts" or "chargeback"
appFunction            = "web"
monthlyBudget          = "5000"
costbaseline           = "2023"  # Year resource created
location               = "eastus"
additionalcontext      = "01"

# Required Inputs
domain_name             = "example003.com"
resource_group_name     = "your-resource-group"

# Optional Inputs
a_records = {
  record1 = {
    name                = "record1"
    resource_group_name = "your-resource-group"
    zone_name           = "example003.com"
    ttl                 = 3600
    records             = ["10.0.0.1"]
    tags                = {
      environment = "production"
    }
  }
}

aaaa_records = {}

cname_records = {
  record1 = {
    name                = "cname1"
    resource_group_name = "your-resource-group"
    zone_name           = "example003.com"
    ttl                 = 3600
    record              = "cname.example003.com"
    tags                = {
      environment = "production"
    }
  }
}

enable_telemetry = true

mx_records = {
  mx1 = {
    name                = "@"
    resource_group_name = "your-resource-group"
    zone_name           = "example003.com"
    ttl                 = 3600
    records             = {
      mail1 = {
        preference = 10
        exchange   = "mail.example003.com"
      }
    }
    tags                = {
      environment = "production"
    }
  }
}

ptr_records = {}

soa_record = {
  email        = "admin.corp.com"
  expire_time  = 604800
  minimum_ttl  = 300
  refresh_time = 3600
  retry_time   = 300
  ttl          = 3600
  tags         = {
    environment = "production"
  }
}

srv_records = {}

tags = {
  environment = "production"
  owner       = "A"
}

txt_records = {}

virtual_network_links = {
  vnetlink1 = {
    vnetlinkname     = "vnet-link-1"
    vnetid           = "/subscriptions/your-Subscription/resourceGroups/your-resource-group/providers/Microsoft.Network/virtualNetworks/your-vnet"
    autoregistration = true
    tags             = {
      environment = "production"
    }
  }
}
```

<!-- END_TF_DOCS -->