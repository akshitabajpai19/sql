# Resource groups

module "resourcegroup" {
  source              = "../"
  name                = var.name
  location            = var.location
  enable_telemetry    = var.enable_telemetry
  lock                = var.lock
  role_assignments    = var.role_assignments
  app_id              = var.app_id
  appname             = var.appname
  env                 = var.env
  costCostCenter      = var.costCostCenter
  costVP              = var.costVP
  costAppOwnerTech    = var.costAppOwnerTech
  msftmigration       = var.msftmigration
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
