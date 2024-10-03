variable "sql_servers" {
  type = map(object({
    name                                         = string
    sql_server_resource_group_name               = string
    location                                     = string
    version                                      = string
    administrator_login_name                     = optional(string, null)
    connection_policy                            = optional(string, null)
    transparent_data_encryption_key_vault_key_id = optional(string, null)
    public_network_access_enabled                = optional(bool, null)
    minimum_tls_version                          = optional(string, null)
    outbound_network_restriction_enabled         = optional(bool, null)
    primary_user_assigned_identity_id            = optional(string, null)
    tags                                         = optional(map(string), null)
    sql_server_keyvault_name                     = optional(string, null)
    sql_server_keyvault_rg_name                  = optional(string, null)
    sql_server_keyvault_secret_name              = optional(string, null)
    identity = optional(map(object({
      type         = string
      identity_ids = list(string)

    })), {})
    azuread_administrator = optional(object({
      login_username              = string
      object_id                   = string
      tenant_id                   = string
      azuread_authentication_only = bool

    }), null)
    additionalcontext = optional(string, null)
  }))

}

variable "sql_server_private_endpoints" {
  type = map(object({
    private_endpoints = optional(map(object({
      name                           = string
      is_manual_connection           = optional(bool)
      private_connection_resource_id = optional(string)
      subresource_names              = list(string)
      request_message                = optional(string)
      private_dns_zone_group_name    = optional(string)
      private_dns_zone_ids           = optional(list(string))
    })), {})
    sql_server_key                       = optional(string, null)
    location                             = optional(string, null)
    tags                                 = optional(map(string), null)
    subscription_id                      = optional(string, null)
    pe_subnet_name                       = optional(string, null)
    virtual_network_rg                   = optional(string, null)
    virtual_network_name                 = optional(string, null)
    private_endpoint_resource_group_name = optional(string, null)
    domain_name                          = optional(string, null)
    a_records = optional(map(object({
      name                = string
      resource_group_name = string
      zone_name           = string
      ttl                 = number
      records             = list(string)
      tags                = optional(map(string), null)
    })), {})
    aaaa_records = optional(map(object({
      name                = string
      resource_group_name = string
      zone_name           = string
      ttl                 = number
      records             = list(string)
      tags                = optional(map(string), null)
    })), {})
    cname_records = optional(map(object({
      name                = string
      resource_group_name = string
      zone_name           = string
      ttl                 = number
      record              = string
      tags                = optional(map(string), null)
    })), {})
    enable_telemetry = optional(bool, false)
    mx_records = optional(map(object({
      name                = optional(string, "@")
      resource_group_name = string
      zone_name           = string
      ttl                 = number
      records = map(object({
        preference = number
        exchange   = string
      }))
    })), {})
    ptr_records = optional(map(object({
      name                = string
      resource_group_name = string
      zone_name           = string
      ttl                 = number
      records             = list(string)
      tags                = optional(map(string), null)
    })), {})
    soa_record = optional(object({
      email        = string
      expire_time  = optional(number, 2419200)
      minimum_ttl  = optional(number, 10)
      refresh_time = optional(number, 3600)
      retry_time   = optional(number, 300)
      ttl          = optional(number, 3600)
      tags         = optional(map(string), null)
    }), null)
    srv_records = optional(map(object({
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
    })), {})
    txt_records = optional(map(object({
      name                = string
      resource_group_name = string
      zone_name           = string
      ttl                 = number
      records = map(object({
        value = string
      }))
      tags = optional(map(string), null)
    })), {})
    virtual_network_links = optional(map(object({
      vnetlinkname     = string
      vnetid           = string
      autoregistration = optional(bool, false)
      tags             = optional(map(string), null)
    })), {})
    #private_connection_resource_id = optional(string, null)
    create_dns_zone                = optional(bool, null)
    dns_zone_id                    = optional(string, null)
    additionalcontext              = optional(string, null)
  }))
}

#Naming and Tags 
variable "location" {
  description = "the location where the resource need to be deployed"
  type        = string
}

variable "resourcetype" {
  description = "the resource type being deployed see naming standards for example"
  type        = string
}

variable "appid" {
  description = "The related application for resources. Used for tagging and naming purposes."
  type        = string
}

variable "appname" {
  description = "the app name for the resources.  Used for tagging and naming purposes"
  type        = string
}

variable "env" {
  description = "The environment code the for resources. Used for tagging and naming purposes."
  type        = string
}

variable "costCostCenter" {
  description = "The cost center code for resources. Used for tagging and naming purposes."
  type        = string
  default = null
}

variable "costVP" {
  description = "The cost vp for resources. Used for tagging purposes."
  type        = string
  default = null
}

variable "costAppOwnerTech" {
  description = "The app owner responsible for resources. Used for tagging and naming purposes."
  type        = string
}

variable "costAppOwnerManager" {
  description = "The app owner manager responsible for resources. Used for tagging purposes."
  type        = string
}

variable "costBudgetOwner" {
  description = "The budget owner responsible for resources. Used for tagging purposes."
  type        = string
}

variable "costDivision" {
  description = "cost division"
  type        = string
}

variable "costAllocation" {
  description = "can only be sharedcosts or chargeback"
  type        = string
}

variable "appFunction" {
  description = "app function"
  type        = string
}

variable "monthlyBudget" {
  description = "monthly budget"
  type        = string
}

variable "costbaseline" {
  description = "year resource created"
  type        = string
}
