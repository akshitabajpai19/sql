module "sqlserverdeploy" {
  source                = "../"
  sql_servers           = var.sql_servers
  identity              = var.identity
  azuread_administrator = var.azuread_administrator
  location              = var.location
  resourcetype          = var.resourcetype
  appid                 = var.appid
  appname               = var.appname
  env                   = var.env
  costCostCenter        = var.costCostCenter
  costVP                = var.costVP
  costAppOwnerTech      = var.costAppOwnerTech
  costAppOwnerManager   = var.costAppOwnerManager
  costBudgetOwner       = var.costBudgetOwner
  costDivision          = var.costDivision
  costAllocation        = var.costAllocation
  appFunction           = var.appFunction
  monthlyBudget         = var.monthlyBudget
  costbaseline          = var.costbaseline
  #additionalcontext   = var.additionalcontext
}