module "cosmos" {

  source              = "../"
  cosmosdb            = var.cosmosdb
  cosmosdb_pgsql      = var.cosmosdb_pgsql
  key_vault_name      = var.key_vault_name
  key_vault_rg_name   = var.key_vault_rg_name
  appid               = var.appid
  appname             = var.appname
  resourcetype        = var.resourcetype
  costAppOwnerManager = var.costAppOwnerManager
  costAppOwnerTech    = var.costAppOwnerTech
  costBudgetOwner     = var.costBudgetOwner
  costCostCenter      = var.costCostCenter
  costDivision        = var.costDivision
  location            = var.location
  costVP              = var.costVP
  env                 = var.env
  costAllocation      = var.costAllocation
  appFunction         = var.appFunction
  monthlyBudget       = var.monthlyBudget
  costbaseline        = var.costbaseline
  additionalcontext   = var.additionalcontext

}
