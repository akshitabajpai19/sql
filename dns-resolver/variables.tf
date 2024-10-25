variable "dnsresolver" {
  type = map(object({
    location                    = string
    name                        = string
    resource_group_name         = string
    virtual_network_resource_id = string
    enable_telemetry            = optional(bool, true)
    inbound_endpoints = optional(map(object({
      name                         = optional(string)
      subnet_name                  = string
      private_ip_allocation_method = optional(string, "Dynamic")
      private_ip_address           = optional(string, null)
    })), {})
    lock = optional(object({
      kind = string
      name = optional(string, null)
    }), null)
    outbound_endpoints = optional(map(object({
      name        = optional(string)
      subnet_name = string
      forwarding_ruleset = optional(map(object({
        name                                                = optional(string)
        link_with_outbound_endpoint_virtual_network         = optional(bool, true)
        metadata_for_outbound_endpoint_virtual_network_link = optional(map(string), null)
        additional_virtual_network_links = optional(map(object({
          vnet_id  = string
          metadata = optional(map(string), null)
        })), {})
        rules = optional(map(object({
          name                     = optional(string)
          domain_name              = string
          destination_ip_addresses = map(string)
          enabled                  = optional(bool, true)
          metadata                 = optional(map(string), null)
        })))
      })))
    })), {})
    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
      principal_type                         = optional(string, null)
    })), {})
    tags = optional(map(string), null)
  }))

}

