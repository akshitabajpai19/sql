locals {
  naming = "${var.appname}${var.env}"
  tags = {
    appid               = var.appid
    appname             = var.appname
    resourcetype        = var.resourcetype
    costAppOwnerManager = var.costAppOwnerManager
    costAppOwnerTech    = var.costAppOwnerTech
    costBudgetOwner     = var.costBudgetOwner
    costCostCenter      = var.costCostCenter
    //costDivision        = var.costDivision
    costRegion = var.location
    //costVP              = var.costVP
    environment      = var.env
    costAllocation   = var.costAllocation #(can only be sharedcosts or chargeback)
    appFunction      = var.appFunction
    monthlyBudget    = var.monthlyBudget
    costbaseline     = var.costbaseline #(year resource created)
    provisioned_by   = "Terraform"
    provisioned_date = timestamp()
  }
}

module "avm-res-network-privatednszone" {
  source = "../private-dns-zone"
  count  = var.create_dns_zone ? 1 : 0
  # Required Inputs
  domain_name         = var.domain_name
  resource_group_name = var.resource_group_name
  # Optional Inputs
  a_records             = var.a_records
  aaaa_records          = var.aaaa_records
  cname_records         = var.cname_records
  enable_telemetry      = var.enable_telemetry
  mx_records            = var.mx_records
  ptr_records           = var.ptr_records
  soa_record            = var.soa_record
  srv_records           = var.srv_records
  tags                  = var.tags
  txt_records           = var.txt_records
  virtual_network_links = var.virtual_network_links
}

locals {
  dns_zone_id = var.create_dns_zone ? module.avm-res-network-privatednszone[0].dns_zone_id : var.dns_zone_id
}


resource "azurerm_private_endpoint" "this" {
  for_each            = var.private_endpoints
  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = "/subscriptions/${var.subscription_id}/resourceGroups/${var.virtual_network_rg}/providers/Microsoft.Network/virtualNetworks/${var.virtual_network_name}/subnets/${var.pe_subnet_name}"

  private_service_connection {
    name                           = "${each.value.name}-psc"
    private_connection_resource_id = var.private_connection_resource_id
    is_manual_connection           = lookup(each.value, "is_manual_connection", false)
    subresource_names              = each.value.subresource_names
    #    request_message                = lookup(each.value, "request_message", null)
  }

  private_dns_zone_group {
    name                 = "pe-${local.naming}-${var.additionalcontext}" #each.value.private_dns_zone_group_name
    private_dns_zone_ids = [local.dns_zone_id]                           #each.value.private_dns_zone_ids
  }

  tags = var.tags
  lifecycle {
    ignore_changes = [
      tags["provisioned_date"]
    ]
  }
  depends_on = [module.avm-res-network-privatednszone]
}