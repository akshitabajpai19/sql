#naming and tags
variable "location" {
  description = "The Azure region where resources will be deployed"
  type        = string
}

variable "resourcetype" {
  description = "the resource type being deployed see naming standards for example"
  type        = string
}

variable "app_id" {
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
}

variable "costVP" {
  description = "The cost vp for resources. Used for tagging purposes."
  type        = string
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

variable "additionalcontext" {
  description = "used for naming purposes such as 01 or 02"
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

variable "vnet_resource_group_name" {
  description = "The name of an existing resource group to be imported."
  type        = string
}

variable "address_space" {
  description = "The address space that is used by the virtual network."
  type        = list(string)
}

# If no values specified, this defaults to Azure DNS
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "A map of subnets to create"
  type = map(object({
    resourcetype      = optional(string)
    additionalcontext = optional(string)
    name              = optional(string)
    address_prefixes  = optional(list(string))
    service_endpoints = optional(list(string), [])
    delegations = optional(map(object({
      name    = string
      actions = list(string)
    })), {})

    nat_gateway = optional(object({
      id = string
    }))
    network_security_group = optional(object({
      id = string
    }))
    private_endpoint_network_policies             = optional(string, "Enabled")
    private_link_service_network_policies_enabled = optional(bool, true)
    route_table = optional(object({
      id = string
    }))
    service_endpoint_policies = optional(map(object({
      id = string
    })))
    default_outbound_access_enabled = optional(bool, false)
    sharing_scope                   = optional(string, null)
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
      principal_type                         = optional(string, null)
    })))
  }))
  default = {}
  validation {
    condition = alltrue([for o in var.subnets : o.name != null ? length(o.name) > 5 : o.resourcetype != null && o.additionalcontext != null])

    error_message = "One of `name` (with lenght > 5) or `resourcetype` + 'additionalcontext' must be supplied."
  }
}

variable "name" {
  type        = string
  default     = null
  description = "allow override of the vnet name"
}


# Other settings
variable "bgp_community" {
  type        = string
  default     = null
  description = <<DESCRIPTION
(Optional) The BGP community to send to the virtual network gateway.
DESCRIPTION
}

variable "ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })
  default     = null
  description = <<DESCRIPTION
Specifies an AzureNetwork DDoS Protection Plan.

- `id`: The ID of the DDoS Protection Plan. (Required)
- `enable`: Enables or disables the DDoS Protection Plan on the Virtual Network. (Required)
DESCRIPTION
}

variable "diagnostic_settings" {
  type = map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
  default     = {}
  description = <<DESCRIPTION
  A map of diagnostic settings to create on the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
  
  - `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.
  - `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.
  - `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.
  - `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.
  - `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.
  - `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.
  - `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.
  - `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.
  - `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.
  - `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs.
  DESCRIPTION
  nullable    = false
}

variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see https://aka.ms/avm/telemetry.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
}

variable "enable_vm_protection" {
  type        = bool
  default     = false
  description = <<DESCRIPTION
(Optional) Enable VM Protection for the virtual network. Defaults to false.
DESCRIPTION
}

variable "encryption" {
  type = object({
    enabled     = bool
    enforcement = string
  })
  default     = null
  description = <<DESCRIPTION
(Optional) Specifies the encryption settings for the virtual network.

- `enabled`: Specifies whether encryption is enabled for the virtual network.
- `enforcement`: Specifies the enforcement mode for the virtual network. Possible values are `Enabled` and `Disabled`.
DESCRIPTION
}

variable "extended_location" {
  type = object({
    name = string
    type = string
  })
  default     = null
  description = <<DESCRIPTION
(Optional) Specifies the extended location of the virtual network.

- `name`: The name of the extended location.
- `type`: The type of the extended location.
DESCRIPTION
}

variable "flow_timeout_in_minutes" {
  type        = number
  default     = null
  description = <<DESCRIPTION
(Optional) The flow timeout in minutes for the virtual network. Defaults to 4.
DESCRIPTION
}

variable "lock" {
  type = object({
    kind = string
    name = optional(string, null)
  })
  default     = null
  description = <<DESCRIPTION
  (Optional) Controls the Resource Lock configuration for this resource. The following properties can be specified:
  
  - `kind` - (Required) The type of lock. Possible values are `\"CanNotDelete\"` and `\"ReadOnly\"`.
  - `name` - (Optional) The name of the lock. If not specified, a name will be generated based on the `kind` value. Changing this forces the creation of a new resource.
  DESCRIPTION
}

variable "peerings" {
  type = map(object({
    name                               = string
    remote_virtual_network_resource_id = string
    allow_forwarded_traffic            = optional(bool, false)
    allow_gateway_transit              = optional(bool, false)
    allow_virtual_network_access       = optional(bool, true)
    do_not_verify_remote_gateways      = optional(bool, false)
    enable_only_ipv6_peering           = optional(bool, false)
    peer_complete_vnets                = optional(bool, true)
    local_peered_address_spaces = optional(list(object({
      address_prefix = string
    })))
    remote_peered_address_spaces = optional(list(object({
      address_prefix = string
    })))
    local_peered_subnets = optional(list(object({
      subnet_name = string
    })))
    remote_peered_subnets = optional(list(object({
      subnet_name = string
    })))
    use_remote_gateways                   = optional(bool, false)
    create_reverse_peering                = optional(bool, false)
    reverse_name                          = optional(string)
    reverse_allow_forwarded_traffic       = optional(bool, false)
    reverse_allow_gateway_transit         = optional(bool, false)
    reverse_allow_virtual_network_access  = optional(bool, true)
    reverse_do_not_verify_remote_gateways = optional(bool, false)
    reverse_enable_only_ipv6_peering      = optional(bool, false)
    reverse_peer_complete_vnets           = optional(bool, true)
    reverse_local_peered_address_spaces = optional(list(object({
      address_prefix = string
    })))
    reverse_remote_peered_address_spaces = optional(list(object({
      address_prefix = string
    })))
    reverse_local_peered_subnets = optional(list(object({
      subnet_name = string
    })))
    reverse_remote_peered_subnets = optional(list(object({
      subnet_name = string
    })))
    reverse_use_remote_gateways = optional(bool, false)
  }))
  default     = {}
  description = <<DESCRIPTION
(Optional) A map of virtual network peering configurations. Each entry specifies a remote virtual network by ID and includes settings for traffic forwarding, gateway transit, and remote gateways usage.

- `name`: The name of the virtual network peering configuration.
- `remote_virtual_network_resource_id`: The resource ID of the remote virtual network.
- `allow_forwarded_traffic`: (Optional) Enables forwarded traffic between the virtual networks. Defaults to false.
- `allow_gateway_transit`: (Optional) Enables gateway transit for the virtual networks. Defaults to false.
- `allow_virtual_network_access`: (Optional) Enables access from the local virtual network to the remote virtual network. Defaults to true.
- `do_not_verify_remote_gateways`: (Optional) Disables the verification of remote gateways for the virtual networks. Defaults to false.
- `enable_only_ipv6_peering`: (Optional) Enables only IPv6 peering for the virtual networks. Defaults to false.
- `peer_complete_vnets`: (Optional) Enables the peering of complete virtual networks for the virtual networks. Defaults to false.
- `local_peered_address_spaces`: (Optional) The address spaces to peer with the remote virtual network. Only used when `peer_complete_vnets` is set to true.
- `remote_peered_address_spaces`: (Optional) The address spaces to peer from the remote virtual network. Only used when `peer_complete_vnets` is set to true.
- `local_peered_subnets`: (Optional) The subnets to peer with the remote virtual network. Only used when `peer_complete_vnets` is set to true.
- `remote_peered_subnets`: (Optional) The subnets to peer from the remote virtual network. Only used when `peer_complete_vnets` is set to true.
- `use_remote_gateways`: (Optional) Enables the use of remote gateways for the virtual networks. Defaults to false.
- `create_reverse_peering`: (Optional) Creates the reverse peering to form a complete peering.
- `reverse_name`: (Optional) If you have selected `create_reverse_peering`, then this name will be used for the reverse peer.
- `reverse_allow_forwarded_traffic`: (Optional) If you have selected `create_reverse_peering`, enables forwarded traffic between the virtual networks. Defaults to false.
- `reverse_allow_gateway_transit`: (Optional) If you have selected `create_reverse_peering`, enables gateway transit for the virtual networks. Defaults to false.
- `reverse_allow_virtual_network_access`: (Optional) If you have selected `create_reverse_peering`, enables access from the local virtual network to the remote virtual network. Defaults to true.
- `reverse_do_not_verify_remote_gateways`: (Optional) If you have selected `create_reverse_peering`, disables the verification of remote gateways for the virtual networks. Defaults to false.
- `reverse_enable_only_ipv6_peering`: (Optional) If you have selected `create_reverse_peering`, enables only IPv6 peering for the virtual networks. Defaults to false.
- `reverse_peer_complete_vnets`: (Optional) If you have selected `create_reverse_peering`, enables the peering of complete virtual networks for the virtual networks. Defaults to false.
- `reverse_local_peered_address_spaces`: (Optional) If you have selected `create_reverse_peering`, the address spaces to peer with the remote virtual network. Only used when `reverse_peer_complete_vnets` is set to true.
- `reverse_remote_peered_address_spaces`: (Optional) If you have selected `create_reverse_peering`, the address spaces to peer from the remote virtual network. Only used when `reverse_peer_complete_vnets` is set to true.
- `reverse_local_peered_subnets`: (Optional) If you have selected `create_reverse_peering`, the subnets to peer with the remote virtual network. Only used when `reverse_peer_complete_vnets` is set to true.
- `reverse_remote_peered_subnets`: (Optional) If you have selected `create_reverse_peering`, the subnets to peer from the remote virtual network. Only used when `reverse_peer_complete_vnets` is set to true.
- `reverse_use_remote_gateways`: (Optional) If you have selected `create_reverse_peering`, enables the use of remote gateways for the virtual networks. Defaults to false.

DESCRIPTION
  nullable    = false
}

variable "role_assignments" {
  type = map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
  default     = {}
  description = <<DESCRIPTION
  (Optional) A map of role assignments to create on the <RESOURCE>. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
  
  - `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
  - `principal_id` - The ID of the principal to assign the role to.
  - `description` - (Optional) The description of the role assignment.
  - `skip_service_principal_aad_check` - (Optional) If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
  - `condition` - (Optional) The condition which will be used to scope the role assignment.
  - `condition_version` - (Optional) The version of the condition syntax. Leave as `null` if you are not using a condition, if you are then valid values are '2.0'.
  - `delegated_managed_identity_resource_id` - (Optional) The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created. This field is only used in cross-tenant scenario.
  - `principal_type` - (Optional) The type of the `principal_id`. Possible values are `User`, `Group` and `ServicePrincipal`. It is necessary to explicitly set this attribute when creating role assignments if the principal creating the assignment is constrained by ABAC rules that filters on the PrincipalType attribute.
  
  > Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.
  DESCRIPTION
  nullable    = false
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "(Optional) Tags of the resource."
}

variable "create_virtual_network" {
  description = "Set this to true if a new virtual network is required."
  type        = bool
  default     = false
}
