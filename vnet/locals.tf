locals {
  default_name = "vnet-${var.appname}-${var.env}-${var.location}-${var.additionalcontext}"
  var_name     = var.name == null ? "" : var.name
  name         = length(local.var_name) > 5 ? local.var_name : local.default_name


  mandatory_tags = tomap({
    app_id              = var.app_id
    appFunction         = var.appFunction
    appname             = var.appname
    costAllocation      = var.costAllocation #(can only be sharedcosts or chargeback)
    costAppOwnerManager = var.costAppOwnerManager
    costAppOwnerTech    = var.costAppOwnerTech
    costbaseline        = var.costbaseline #(year resource created)
    costBudgetOwner     = var.costBudgetOwner
    costCostCenter      = var.costCostCenter
    costDivision        = var.costDivision
    costRegion          = var.location
    costVP              = var.costVP
    environment         = var.env
    monthlyBudget       = var.monthlyBudget
    provisioned_by      = "Terraform"
    provisioned_date    = timestamp()
    resourcetype        = var.resourcetype
  })
}
