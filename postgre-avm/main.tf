#########################################
# Data sources
#########################################

data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg_name
}

#########################################
# Resource Creation : Random password 
#########################################
resource "random_password" "administrator_password" {
  length           = 12
  lower            = true
  min_lower        = 2
  min_numeric      = 2
  min_special      = 2
  min_upper        = 2
  override_special = "_"
  special          = true
  upper            = true
}

#---------------------------------------------------------------
# Resource Creation: KeyVault Secret to store admin passwords
#---------------------------------------------------------------
resource "azurerm_key_vault_secret" "this" {
  name            = "${var.posgresql_server_name}-password"
  value           = random_password.administrator_password.result
  key_vault_id    = data.azurerm_key_vault.kv.id
  content_type    = var.kv_secret_content_type
  expiration_date = var.kv_secret_expiration_date
}

module "avm-res-dbforpostgresql-flexibleserver" {
  source                                  = "Azure/avm-res-dbforpostgresql-flexibleserver/azurerm"
  version                                 = "0.1.0"
  location                                = var.location
  name                                    = var.posgresql_server_name
  resource_group_name                     = var.resource_group_name
  administrator_login                     = var.administrator_login
  administrator_password                  = random_password.administrator_password.result
  authentication                          = var.authentication
  auto_grow_enabled                       = var.auto_grow_enabled
  backup_retention_days                   = var.backup_retention_days
  create_mode                             = var.create_mode
  customer_managed_key                    = var.customer_managed_key
  databases                               = var.databases
  delegated_subnet_id                     = var.delegated_subnet_id
  diagnostic_settings                     = var.diagnostic_settings
  enable_telemetry                        = var.enable_telemetry
  geo_redundant_backup_enabled            = var.geo_redundant_backup_enabled
  high_availability                       = var.high_availability
  lock                                    = var.lock
  maintenance_window                      = var.maintenance_window
  managed_identities                      = var.managed_identities
  point_in_time_restore_time_in_utc       = var.point_in_time_restore_time_in_utc
  private_dns_zone_id                     = var.private_dns_zone_id
  private_endpoints                       = var.private_endpoints
  private_endpoints_manage_dns_zone_group = var.private_endpoints_manage_dns_zone_group
  public_network_access_enabled           = var.public_network_access_enabled
  replication_role                        = var.replication_role
  role_assignments                        = var.role_assignments
  server_version                          = var.server_version
  sku_name                                = var.sku_name
  source_server_id                        = var.source_server_id
  storage_mb                              = var.storage_mb
  tags                                    = local.tags
  timeouts                                = var.timeouts
  zone                                    = var.zone
}
