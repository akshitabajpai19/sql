# Resource groups

module "avm-res-resources-resourcegroup" {
  source              = "../resource-groups"
  name                = var.name
  location            = var.location
  enable_telemetry    = var.enable_telemetry
  lock                = var.lock
  role_assignments    = var.role_assignments
  appid               = var.appid
  appname             = var.appname
  env                 = var.env
  costCostCenter      = var.costCostCenter
  costVP              = var.costVP
  costAppOwnerTech    = var.costAppOwnerTech
  costAppOwnerManager = var.costAppOwnerManager
  costBudgetOwner     = var.costBudgetOwner
  costbaseline        = var.costbaseline
  resourcetype        = var.resourcetype
  costDivision        = var.costDivision
  costAllocation      = var.costAllocation
  appFunction         = var.appFunction
  monthlyBudget       = var.monthlyBudget
  additionalcontext   = var.additionalcontext
  managed_by          = var.managed_by
}