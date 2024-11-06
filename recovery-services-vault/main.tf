#---------------------------------
# Local declarations
#---------------------------------
locals {
  naming = "${var.appname}${var.env}"
  tags = {
    appid               = var.appid
    appname             = var.appname
    resourcetype        = var.resourcetype
    costAppOwnerManager = var.costAppOwnerManager
    costAppOwnerTech    = var.costAppOwnerTech
    costBudgetOwner     = var.costBudgetOwner
    costCostCenter      = var.costCostCenter
    //costDivision        = var.costDivision
    costRegion = var.location
    //costVP              = var.costVP
    environment      = var.env
    costAllocation   = var.costAllocation #(can only be sharedcosts or chargeback)
    appFunction      = var.appFunction
    monthlyBudget    = var.monthlyBudget
    costbaseline     = var.costbaseline #(year resource created)
    provisioned_by   = "Terraform"
    provisioned_date = timestamp()
  }
  resource_group_name = element(coalescelist(data.azurerm_resource_group.rgrp[*].name, module.avm_res_resources_resourcegroup[*].name, [""]), 0)
}


module "avm_res_resources_resourcegroup" {
  count               = var.create_resource_group ? 1 : 0
  source              = "../resource-groups"
  name                = var.resource_group_name
  location            = var.location
  enable_telemetry    = var.enable_telemetry
  lock                = var.lock
  role_assignments    = var.rg_role_assignments
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

#---------------------------------------------------------
# Data Sources
#----------------------------------------------------------
data "azurerm_resource_group" "rgrp" {
  count = var.create_resource_group ? 0 : 1
  name  = var.resource_group_name
}

data "azurerm_key_vault" "kv" {
  count               = var.enable_encryption ? 1 : 0
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg_name
}

data "azurerm_key_vault_key" "kv_key" {
  count        = var.enable_encryption ? 1 : 0
  name         = var.key_vault_key_name
  key_vault_id = data.azurerm_key_vault.kv[0].id
}

data "azurerm_user_assigned_identity" "this" {
  count               = var.recovery_vault_identity_type == "UserAssigned" || var.recovery_vault_identity_type == "SystemAssigned, UserAssigned" ? 1 : 0
  name                = var.existing_user_assigned_identity_name
  resource_group_name = var.user_assigned_identity_rg_name
}

#---------------------------------------------------------
# Recovery Services Vault resource creation
#----------------------------------------------------------
resource "azurerm_recovery_services_vault" "vault" {
  name                          = var.recovery_services_vault_name != null ? var.recovery_services_vault_name : "rv${local.naming}${var.additionalcontext}"
  location                      = var.location
  resource_group_name           = local.resource_group_name
  sku                           = var.recovery_vault_sku
  storage_mode_type             = var.recovery_vault_storage_mode_type
  cross_region_restore_enabled  = var.recovery_vault_cross_region_restore_enabled
  soft_delete_enabled           = var.recovery_vault_soft_delete_enabled
  public_network_access_enabled = var.recovery_vault_public_access_enabled
  immutability                  = var.recovery_vault_immutability
  tags                          = local.tags

  identity {
    type         = var.recovery_vault_identity_type
    identity_ids = var.recovery_vault_identity_type == "UserAssigned" || var.recovery_vault_identity_type == "SystemAssigned, UserAssigned" ? [data.azurerm_user_assigned_identity.this[0].id] : null
  }

  dynamic "encryption" {
    for_each = var.enable_encryption == true ? { this = var.enable_encryption } : {}

    content {
      key_id                            = var.enable_encryption ? data.azurerm_key_vault_key.kv_key[0].id : null
      infrastructure_encryption_enabled = var.enable_encryption ? var.infrastructure_encryption_enabled : false
      user_assigned_identity_id         = var.enable_encryption && var.recovery_vault_identity_type == "UserAssigned" ? data.azurerm_user_assigned_identity.this[0].id : null
      use_system_assigned_identity      = var.enable_encryption && var.recovery_vault_identity_type != "UserAssigned" ? true : false
    }
  }
}

#Role assignment for Key Vault
module "role_assignments" {
  count            = var.enable_encryption ? 1 : 0
  source           = "Azure/avm-res-authorization-roleassignment/azurerm"
  version          = "0.1.0"
  depends_on       = [azurerm_recovery_services_vault.vault]
  enable_telemetry = false
  user_assigned_managed_identities_by_resource_group_and_name = try(var.recovery_vault_identity_type, "UserAssigned") != "UserAssigned" ? null : {
    rsv_user_identity = {
      resource_group_name = var.user_assigned_identity_rg_name
      name                = var.existing_user_assigned_identity_name
    }
  }
  role_definitions = {
    key_vault_crypto_officer = {
      name = var.kv_role_definition
    }
  }
  system_assigned_managed_identities_by_principal_id = try(var.recovery_vault_identity_type, "SystemAssigned") != "SystemAssigned" ? null : {
    rsv_system_identity = azurerm_recovery_services_vault.vault.identity[0].principal_id
  }
  role_assignments_for_resources = {
    kv_role = {
      resource_name       = var.key_vault_name
      resource_group_name = var.key_vault_rg_name
      role_assignments = {
        role_assignment = {
          role_definition                    = "key_vault_crypto_officer"
          system_assigned_managed_identities = try(var.recovery_vault_identity_type, "SystemAssigned") != "SystemAssigned" ? null : ["rsv_system_identity"]
          user_assigned_managed_identities   = try(var.recovery_vault_identity_type, "UserAssigned") != "UserAssigned" ? null : ["rsv_user_identity"]
        }
      }
    }
  }
}

#---------------------------------------------------------
# Backup Policy for VMs
#---------------------------------------------------------
resource "azurerm_backup_policy_vm" "vm_backup_policy" {
  for_each                       = var.vm_backup_policies
  name                           = each.value.name
  resource_group_name            = local.resource_group_name
  recovery_vault_name            = azurerm_recovery_services_vault.vault.name
  policy_type                    = each.value.policy_type
  timezone                       = each.value.timezone
  instant_restore_retention_days = each.value.instant_restore_retention_days

  backup {
    frequency     = each.value.frequency
    time          = each.value.time
    hour_duration = each.value.hour_duration
    hour_interval = each.value.hour_interval
    weekdays      = each.value.weekdays
  }

  dynamic "retention_daily" {
    for_each = each.value.daily
    content {
      count = retention_daily.value.count
    }
  }

  dynamic "retention_weekly" {
    for_each = each.value.weekly
    content {
      count    = retention_weekly.value.count
      weekdays = retention_weekly.value.weekdays
    }
  }

  dynamic "retention_monthly" {
    for_each = each.value.monthly
    content {
      count             = retention_monthly.value.count
      weekdays          = retention_monthly.value.weekdays
      weeks             = retention_monthly.value.weeks
      days              = retention_monthly.value.days
      include_last_days = retention_monthly.value.include_last_days
    }
  }

  dynamic "retention_yearly" {
    for_each = each.value.yearly
    content {
      count             = retention_yearly.value.count
      weekdays          = retention_yearly.value.weekdays
      weeks             = retention_yearly.value.weeks
      months            = retention_yearly.value.months
      days              = retention_yearly.value.days
      include_last_days = retention_yearly.value.include_last_days
    }
  }
}

#---------------------------------------------------------
# File share backup policy
#---------------------------------------------------------
resource "azurerm_backup_policy_file_share" "file_share_backup_policy" {
  for_each            = var.file_share_backup_policies
  name                = each.value.name
  resource_group_name = local.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name
  timezone            = each.value.timezone

  backup {
    frequency = each.value.frequency
    time      = each.value.time
  }

  dynamic "retention_daily" {
    for_each = each.value.daily
    content {
      count = retention_daily.value.count
    }
  }

  dynamic "retention_weekly" {
    for_each = each.value.weekly
    content {
      count    = retention_weekly.value.count
      weekdays = retention_weekly.value.weekdays
    }
  }

  dynamic "retention_monthly" {
    for_each = each.value.monthly
    content {
      count             = retention_monthly.value.count
      weekdays          = retention_monthly.value.weekdays
      weeks             = retention_monthly.value.weeks
      days              = retention_monthly.value.days
      include_last_days = retention_monthly.value.include_last_days
    }
  }

  dynamic "retention_yearly" {
    for_each = each.value.yearly
    content {
      count             = retention_yearly.value.count
      weekdays          = retention_yearly.value.weekdays
      weeks             = retention_yearly.value.weeks
      months            = retention_yearly.value.months
      days              = retention_yearly.value.days
      include_last_days = retention_yearly.value.include_last_days
    }
  }
}

#---------------------------------------------------------------
# Resource creation: Key Vault Private Endpoint
#---------------------------------------------------------------


module "private-endpoint-setup" {
  source                         = "../private-endpoint"
  for_each                       = var.enable_private_endpoint == true ? { this = var.enable_private_endpoint } : {}
  domain_name                    = var.domain_name
  resource_group_name            = var.resource_group_name
  a_records                      = var.a_records
  aaaa_records                   = var.aaaa_records
  cname_records                  = var.cname_records
  enable_telemetry               = var.enable_telemetry
  mx_records                     = var.mx_records
  ptr_records                    = var.ptr_records
  soa_record                     = var.soa_record
  srv_records                    = var.srv_records
  tags                           = local.tags
  txt_records                    = var.txt_records
  virtual_network_links          = var.virtual_network_links
  private_endpoints              = var.private_endpoints
  location                       = var.location
  subscription_id                = var.subscription_id
  virtual_network_rg             = var.virtual_network_rg
  virtual_network_name           = var.virtual_network_name
  pe_subnet_name                 = var.pe_subnet_name
  private_connection_resource_id = azurerm_recovery_services_vault.vault.id
  dns_zone_id                    = var.dns_zone_id
  create_dns_zone                = var.create_dns_zone
  additionalcontext              = var.additionalcontext
  depends_on                     = [azurerm_recovery_services_vault.vault]
}

#--------------------------------------------------------------
# Diagnostics Settings
#--------------------------------------------------------------

module "diagnostics-setting-setup" {
  source                         = "../diagnostic-setting"
  for_each                       = var.enable_diagnostic_setting == true ? { this = var.enable_diagnostic_setting } : {}
  resource_id                    = azurerm_recovery_services_vault.vault.id
  diagnostics_settings_name      = var.diagnostics_settings_name != null ? var.diagnostics_settings_name : "rv${local.naming}${var.additionalcontext}"
  log_categories                 = var.log_categories
  excluded_log_categories        = var.excluded_log_categories
  metric_categories              = var.metric_categories
  logs_destinations_ids          = var.logs_destinations_ids
  log_analytics_destination_type = var.log_analytics_destination_type
  depends_on                     = [azurerm_recovery_services_vault.vault]
}