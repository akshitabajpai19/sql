module "sqlserverdeploy" {
  source                       = "../"
  sql_servers                  = var.sql_servers
  sql_server_private_endpoints = var.sql_server_private_endpoints
  location                     = var.location
  resourcetype                 = var.resourcetype
  appid                        = var.appid
  appname                      = var.appname
  env                          = var.env
  costAppOwnerTech             = var.costAppOwnerTech
  costAppOwnerManager          = var.costAppOwnerManager
  costBudgetOwner              = var.costBudgetOwner
  costDivision                 = var.costDivision
  costAllocation               = var.costAllocation
  appFunction                  = var.appFunction
  monthlyBudget                = var.monthlyBudget
  costbaseline                 = var.costbaseline
  costCostCenter               = var.costCostCenter
  costVP                       = var.costVP
}
}}}