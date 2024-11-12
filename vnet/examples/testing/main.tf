module "vnet" {
  #source                   = "github.com/CenturyLink/tf-modules-azure//vnet?ref=2.3.0"
  #count                    = var.create_virtual_network ? 1 : 0
  source                   = "../../"
  app_id                   = var.app_id
  appname                  = var.appname
  resourcetype             = var.resourcetype
  costAppOwnerManager      = var.costAppOwnerManager
  costAppOwnerTech         = var.costAppOwnerTech
  costBudgetOwner          = var.costBudgetOwner
  costCostCenter           = var.costCostCenter
  costDivision             = var.costDivision
  costVP                   = var.costVP
  env                      = var.env
  costAllocation           = var.costAllocation #(can only be sharedcosts or chargeback)
  appFunction              = var.appFunction
  monthlyBudget            = var.monthlyBudget
  costbaseline             = var.costbaseline #(year resource created)
  location                 = var.location
  additionalcontext        = var.additionalcontext
  vnet_resource_group_name = var.vnet_resource_group_name
  name                     = var.name
  address_space            = var.address_space
  dns_servers              = var.dns_servers
  subnets                  = var.subnets
  create_virtual_network   = var.create_virtual_network
  bgp_community            = var.bgp_community
  ddos_protection_plan     = var.ddos_protection_plan
  diagnostic_settings      = var.diagnostic_settings
  enable_telemetry         = var.enable_telemetry
  enable_vm_protection     = var.enable_vm_protection
  encryption               = var.encryption
  extended_location        = var.extended_location
  flow_timeout_in_minutes  = var.flow_timeout_in_minutes
  lock                     = var.lock
  peerings                 = var.peerings
  role_assignments         = var.role_assignments
  tags                     = var.tags

  # providers = {
  #   azurerm = azurerm.main
  # }
}
