module "avm-res-network-virtualnetwork" {
  count                    = var.create_virtual_network ? 1 : 0
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.4.0"

  name                = local.name
  location            = var.location
  address_space       = var.address_space
  resource_group_name = var.vnet_resource_group_name
  dns_servers = {
    dns_servers = var.dns_servers
  }
  tags = merge(local.mandatory_tags, var.tags)

  subnets = {
    for k, v in var.subnets :
    k => {
      name              = v.name != null ? v.name : "${v.resourcetype}-${var.appname}-${var.env}${var.location == "" ? "" : format("%s-%s", "", var.location)}-${v.additionalcontext}"
      address_prefix    = length(v.address_prefixes) == 1 ? v.address_prefixes[0] : null
      address_prefixes  = v.address_prefixes
      service_endpoints = v.service_endpoints
      delegation = [
        for kd, vd in v.delegations :
        {
          name = kd
          service_delegation = {
            name    = vd["name"]
            actions = vd["actions"]
          }
        }
      ]
      default_outbound_access_enabled               = v.default_outbound_access_enabled
      nat_gateway                                   = v.nat_gateway
      network_security_group                        = v.network_security_group
      private_endpoint_network_policies             = v.private_endpoint_network_policies
      private_link_service_network_policies_enabled = v.private_link_service_network_policies_enabled
      role_assignments                              = v.role_assignments
      route_table                                   = v.route_table
      service_endpoint_policies                     = v.service_endpoint_policies
      sharing_scope                                 = v.sharing_scope
    }
  }

  bgp_community           = var.bgp_community
  ddos_protection_plan    = var.ddos_protection_plan
  diagnostic_settings     = var.diagnostic_settings
  enable_telemetry        = var.enable_telemetry
  enable_vm_protection    = var.enable_vm_protection
  encryption              = var.encryption
  extended_location       = var.extended_location
  flow_timeout_in_minutes = var.flow_timeout_in_minutes
  lock                    = var.lock
  peerings                = var.peerings
  role_assignments        = var.role_assignments
}
