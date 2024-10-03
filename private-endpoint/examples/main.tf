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

#---------------------------------------------------------
# Resource Group Creation or selection - Default is "false"
#----------------------------------------------------------
resource "azurerm_resource_group" "rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = lower(var.resource_group_name)
  location = var.location
  tags     = var.tags
}

#---------------------------------------------------------
# Data Sources
#----------------------------------------------------------
data "azurerm_resource_group" "rgrp" {
  count = var.create_resource_group ? 0 : 1
  name  = var.resource_group_name
}

module "private-endpoint-setup" {
  source                         = "../"
  for_each                       = var.enable_private_endpoint == true ? { this = var.enable_private_endpoint } : {}
  domain_name                    = var.domain_name
  resource_group_name            = var.resource_group_name
  a_records                      = var.a_records
  aaaa_records                   = var.aaaa_records
  cname_records                  = var.cname_records
  enable_telemetry               = var.enable_telemetry
  mx_records                     = var.mx_records
  ptr_records                    = var.ptr_records
  soa_record                     = var.soa_record
  srv_records                    = var.srv_records
  tags                           = local.tags
  txt_records                    = var.txt_records
  virtual_network_links          = var.virtual_network_links
  private_endpoints              = var.private_endpoints
  location                       = var.location
  subscription_id                = var.subscription_id
  virtual_network_rg             = var.virtual_network_rg
  virtual_network_name           = var.virtual_network_name
  pe_subnet_name                 = var.pe_subnet_name
  private_connection_resource_id = var.private_connection_resource_id
  dns_zone_id                    = var.dns_zone_id
  create_dns_zone                = var.create_dns_zone
  additionalcontext              = var.additionalcontext
  depends_on                     = [azurerm_resource_group.rg]
}