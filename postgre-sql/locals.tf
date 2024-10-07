locals {
  subscription_id = var.subscription_id != null ? var.subscription_id : data.azurerm_client_config.current.subscription_id
  mandatory_tags = tomap({
    appid               = var.appid
    appname             = var.appname
    resourcetype        = var.resourcetype
    costAppOwnerManager = var.costAppOwnerManager
    costAppOwnerTech    = var.costAppOwnerTech
    costBudgetOwner     = var.costBudgetOwner
    costCostCenter      = var.costCostCenter
    costRegion          = var.location
    environment         = var.env
    costVP              = var.costVP
    costbaseline        = var.costbaseline #(year resource created)
    costDivision        = var.costDivision
    costAllocation      = var.costAllocation
    monthlyBudget       = var.monthlyBudget
    appFunction         = var.appFunction
    provisioned_by      = "Terraform"
    provisioned_date    = timestamp()
  })

  tags = merge(var.tags, local.mandatory_tags)
}
