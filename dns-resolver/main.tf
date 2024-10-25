module "avm-res-network-dnsresolver" {
  source                      = "Azure/avm-res-network-dnsresolver/azurerm"
  version                     = "0.4.0"
  for_each                    = var.dnsresolver
  location                    = each.value.location
  name                        = each.value.name
  resource_group_name         = each.value.resource_group_name
  virtual_network_resource_id = each.value.virtual_network_resource_id

  #optional variables
  enable_telemetry   = try(each.value.enable_telemetry, null) != null ? each.value.enable_telemetry : true
  inbound_endpoints  = try(each.value.inbound_endpoints, null) != null ? each.value.inbound_endpoints : {}
  lock               = try(each.value.lock, null)
  outbound_endpoints = try(each.value.outbound_endpoints, null) != null ? each.value.outbound_endpoints : {}
  role_assignments   = try(each.value.role_assignments, null) != null ? each.value.role_assignments : {}
  tags               = try(each.value.tags, null)
}
