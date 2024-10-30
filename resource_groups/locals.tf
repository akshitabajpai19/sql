locals {
  naming = "${var.resourcetype}-${var.appname}-${var.env}"

  name = var.name != null ? var.name : "${local.naming}-${var.additionalcontext}"

  mandatory_tags = tomap({
    app_id              = var.app_id
    appname             = var.appname
    resourcetype        = var.resourcetype
    costAppOwnerManager = var.costAppOwnerManager
    costAppOwnerTech    = var.costAppOwnerTech
    costBudgetOwner     = var.costBudgetOwner
    costCostCenter      = var.costCostCenter
    costDivision        = var.costDivision
    msftmigration       = var.msftmigration
    costRegion          = var.location
    costVP              = var.costVP
    environment         = var.env
    costAllocation      = var.costAllocation #(can only be sharedcosts or chargeback)
    appFunction         = var.appFunction
    monthlyBudget       = var.monthlyBudget
    costbaseline        = var.costbaseline #(year resource created)
    provisioned_by      = "Terraform"
    provisioned_date    = timestamp()
  })

  tags = merge(var.tags, local.mandatory_tags)
}
