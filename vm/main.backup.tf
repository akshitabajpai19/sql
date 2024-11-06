locals {
  recovery_name                      = substr("arsv-${local.naming}", 0, 50)
  role_definition_resource_substring = "/providers/Microsoft.Authorization/roleDefinitions"

}

module "recovery" {
  source                               = "../recovery-services-vault"
  recovery_services_vault_name         = var.recovery_services_vault_name
  location                             = var.recovery_location
  resource_group_name                  = var.recovery_resource_group_name
  lock                                 = var.recovery_lock
  rg_role_assignments                  = var.recovery_rg_role_assignments
  create_resource_group                = var.recovery_create_resource_group
  enable_encryption                    = var.recovery_enable_encryption
  key_vault_name                       = var.recovery_key_vault_name
  key_vault_rg_name                    = var.recovery_key_vault_rg_name
  key_vault_key_name                   = var.recovery_key_vault_key_name
  kv_role_definition                   = var.recovery_kv_role_definition
  recovery_vault_identity_type         = var.recovery_vault_identity_type
  recovery_vault_public_access_enabled = var.recovery_vault_public_access_enabled
  vm_backup_policies                   = var.recovery_vm_backup_policies
  subscription_id                      = var.recovery_subscription_id
  pe_subnet_name                       = var.recovery_pe_subnet_name
  virtual_network_name                 = var.recovery_virtual_network_name
  virtual_network_rg                   = var.recovery_virtual_network_rg
  private_endpoints                    = var.recovery_private_endpoints
  tags                                 = var.recovery_tags
  enable_diagnostic_setting            = var.recovery_enable_diagnostic_setting
  diagnostics_settings_name            = var.recovery_diagnostics_settings_name
  log_categories                       = var.recovery_log_categories
  excluded_log_categories              = var.recovery_excluded_log_categories
  metric_categories                    = var.recovery_metric_categories
  logs_destinations_ids                = var.recovery_logs_destinations_ids
  log_analytics_destination_type       = var.recovery_log_analytics_destination_type
  domain_name                          = var.recovery_domain_name
  a_records                            = var.recovery_a_records
  aaaa_records                         = var.recovery_aaaa_records
  cname_records                        = var.recovery_cname_records
  enable_telemetry                     = var.recovery_enable_telemetry
  mx_records                           = var.recovery_mx_records
  ptr_records                          = var.recovery_ptr_records
  soa_record                           = var.recovery_soa_record
  srv_records                          = var.recovery_srv_records
  txt_records                          = var.recovery_txt_records
  virtual_network_links                = var.recovery_virtual_network_links
  enable_private_endpoint              = var.recovery_enable_private_endpoint
  dns_zone_id                          = var.recovery_dns_zone_id
  create_dns_zone                      = var.recovery_create_dns_zone
  appid                                = var.appid
  appname                              = var.appname
  resourcetype                         = var.resourcetype
  costAppOwnerManager                  = var.costAppOwnerManager
  costAppOwnerTech                     = var.costAppOwnerTech
  costBudgetOwner                      = var.costBudgetOwner
  costCostCenter                       = var.costCostCenter
  costDivision                         = var.costDivision
  costVP                               = var.costVP
  env                                  = var.env
  costAllocation                       = var.costAllocation #(can only be sharedcosts or chargeback)
  appFunction                          = var.appFunction
  monthlyBudget                        = var.monthlyBudget
  costbaseline                         = var.costbaseline #(year resource created)
  additionalcontext                    = var.additionalcontext
  user_assigned_identity_rg_name       = var.user_assigned_identity_rg_name
  existing_user_assigned_identity_name = var.existing_user_assigned_identity_name
  managed_by                           = var.managed_by

}
