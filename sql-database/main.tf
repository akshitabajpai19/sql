data "azurerm_mssql_server" "this" {
  for_each            = var.database_names
  name                = each.value.sql_server_name
  resource_group_name = each.value.server_resource_group_name
}

resource "azurerm_mssql_database" "this" {
  for_each                                                   = var.database_names
  name                                                       = each.value["name"]
  server_id                                                  = data.azurerm_mssql_server.this[each.key].id
  collation                                                  = lookup(each.value, "db_collation", null)
  max_size_gb                                                = lookup(each.value, "max_size_gb", null)
  sku_name                                                   = lookup(each.value, "sku_name", null)
  zone_redundant                                             = lookup(each.value, "zone_redundant", false)
  elastic_pool_id                                            = lookup(each.value, "elastic_pool_id", null)
  create_mode                                                = lookup(each.value, "create_mode", null)
  creation_source_database_id                                = lookup(each.value, "creation_source_database_id", null)
  restore_point_in_time                                      = lookup(each.value, "restore_point_in_time", null)
  auto_pause_delay_in_minutes                                = lookup(each.value, "auto_pause_delay_in_minutes", null)
  enclave_type                                               = lookup(each.value, "enclave_type", null)
  geo_backup_enabled                                         = lookup(each.value, "geo_backup_enabled", true)
  maintenance_configuration_name                             = lookup(each.value, "maintenance_configuration_name", null)
  ledger_enabled                                             = lookup(each.value, "ledger_enabled", false)
  license_type                                               = lookup(each.value, "license_type", null)
  min_capacity                                               = lookup(each.value, "min_capacity", null)
  recover_database_id                                        = lookup(each.value, "recover_database_id", null)
  recovery_point_id                                          = lookup(each.value, "recovery_point_id", null)
  restore_dropped_database_id                                = lookup(each.value, "restore_dropped_database_id", null)
  restore_long_term_retention_backup_id                      = lookup(each.value, "restore_long_term_retention_backup_id", null)
  read_replica_count                                         = lookup(each.value, "read_replica_count", null)
  read_scale                                                 = lookup(each.value, "read_scale", null)
  sample_name                                                = lookup(each.value, "sample_name", null)
  storage_account_type                                       = lookup(each.value, "storage_account_type", null)
  transparent_data_encryption_enabled                        = lookup(each.value, "transparent_data_encryption_enabled", true)
  transparent_data_encryption_key_vault_key_id               = lookup(each.value, "transparent_data_encryption_key_vault_key_id", null)
  transparent_data_encryption_key_automatic_rotation_enabled = lookup(each.value, "transparent_data_encryption_key_automatic_rotation_enabled", null)
  secondary_type                                             = lookup(each.value, "secondary_type", null)

  tags       = merge(each.value["tags"], local.tags)
  lifecycle {
    prevent_destroy = true
  }
  ''
  depends_on = [data.azurerm_mssql_server.this]
}