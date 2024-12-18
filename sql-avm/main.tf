data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg_name
}

data "azurerm_storage_account" "storage" {
  name                = var.storage_account_name
  resource_group_name = var.storage_account_rg
}

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

resource "azurerm_key_vault_secret" "this" {
  name            = "${var.name}-password"
  value           = random_password.administrator_password.result
  key_vault_id    = data.azurerm_key_vault.kv.id
  content_type    = "Azure USER PASS secret"
  expiration_date = timeadd(timestamp(), "8760h")
}

module "avm-res-sql-server" {
  source                                       = "Azure/avm-res-sql-server/azurerm"
  version                                      = "0.1.1"
  location                                     = var.location
  resource_group_name                          = var.resource_group_name
  server_version                               = var.server_version
  administrator_login                          = var.administrator_login
  administrator_login_password                 = random_password.administrator_password.result
  azuread_administrator                        = var.azuread_administrator
  connection_policy                            = var.connection_policy
  databases                                    = var.databases
  diagnostic_settings                          = var.diagnostic_settings
  elastic_pools                                = var.elastic_pools
  enable_telemetry                             = var.enable_telemetry
  firewall_rules                               = var.firewall_rules
  lock                                         = var.lock
  managed_identities                           = var.managed_identities
  name                                         = var.name
  outbound_network_restriction_enabled         = var.outbound_network_restriction_enabled
  primary_user_assigned_identity_id            = var.primary_user_assigned_identity_id
  private_endpoints                            = var.private_endpoints
  public_network_access_enabled                = var.public_network_access_enabled
  role_assignments                             = var.role_assignments
  tags                                         = local.tags
  transparent_data_encryption_key_vault_key_id = var.transparent_data_encryption_key_vault_key_id
}

resource "azurerm_mssql_server_extended_auditing_policy" "this" {
  server_id                               = module.avm-res-sql-server.resource_id
  storage_endpoint                        = data.azurerm_storage_account.storage.primary_blob_endpoint
  storage_account_access_key              = data.azurerm_storage_account.storage.primary_access_key
  storage_account_access_key_is_secondary = var.storage_account_access_key_is_secondary
  retention_in_days                       = var.retention_in_days
}