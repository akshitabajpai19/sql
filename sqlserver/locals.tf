locals {
  naming = "${var.resourcetype}${var.appname}${var.env}"
  mandatory_tags = {
    Metadata = jsonencode({
      appid               = var.appid
      appname             = var.appname
      resourcetype        = var.resourcetype
      costAppOwnerManager = var.costAppOwnerManager
      costAppOwnerTech    = var.costAppOwnerTech
      costBudgetOwner     = var.costBudgetOwner
      costCostCenter      = var.costCostCenter
      costDivision        = var.costDivision
    })
    Metadata2 = jsonencode({
      costRegion       = var.location
      costVP           = var.costVP
      environment      = var.env
      costAllocation   = var.costAllocation #(can only be sharedcosts or chargeback)
      appFunction      = var.appFunction
      monthlyBudget    = var.monthlyBudget
      costbaseline     = var.costbaseline #(year resource created)
      provisioned_by   = "Terraform"
      provisioned_date = timestamp()
    })
  }
  
}
