locals {
  akv_role_assigments = {
    "akv-example-admin" = {
      role_definition_id_or_name = "Key Vault Administrator"
      principal_id               = "0000000-0000-0000-0000-00000000000"
    },
    "akv-example-reader" = {
      role_definition_id_or_name = "Key Vault Secrets Officer"
      principal_id               = "0000000-0000-0000-0000-00000000000"
    },
    "akv-example-spn-secrets-user" = {
      role_definition_id_or_name = "Key Vault Secrets User"
      principal_id               = data.azuread_service_principal.spn.id
    },
  }
}


module "akv-example-infra-prod-01" {
  source                     = "github.com/CenturyLink/tf-modules-azure//key-vault?ref=2.0.0"
  appid                      = var.appid
  appname                    = var.appname
  resourcetype               = "akv"
  costAppOwnerManager        = var.costAppOwnerManager
  costAppOwnerTech           = var.costAppOwnerTech
  costBudgetOwner            = var.costBudgetOwner
  costCostCenter             = var.costCostCenter
  costDivision               = var.costDivision
  costVP                     = var.costVP
  env                        = var.env
  costAllocation             = var.costAllocation #(can only be sharedcosts or chargeback)
  appFunction                = var.appFunction
  monthlyBudget              = var.monthlyBudget
  costbaseline               = var.costbaseline #(year resource created)
  location                   = var.location
  additionalcontext          = var.additionalcontext
  resource_group_name        = data.azurerm_resource_group.rg_application.name
  private_dns_zone_ids       = data.azurerm_private_dns_zone.kv.id
  subnet_id                  = data.azurerm_subnet.private_endpoint.id
  tenant_id                  = var.tenant_id
  sku_name                   = "standard"
  role_assignments           = local.akv_role_assigments
  soft_delete_retention_days = 90

  providers = {
    azurerm = azurerm.main
  }
}
