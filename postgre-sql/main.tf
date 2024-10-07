#########################################
# Data sources
#########################################
data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg_name
}


#########################################
# Resource Creation : Random password 
#########################################
resource "random_password" "posgresql_password" {
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
  value           = random_password.posgresql_password.result
  key_vault_id    = data.azurerm_key_vault.kv.id
  content_type    = var.kv_secret_content_type
  expiration_date = var.kv_secret_expiration_date
}

###############################################
# Resource Creation: PostgreSQL Flexible Server
###############################################
resource "azurerm_postgresql_flexible_server" "posgresflexible" {
  name                              = var.posgresql_server_name
  resource_group_name               = data.azurerm_resource_group.rg.name
  location                          = data.azurerm_resource_group.rg.location
  delegated_subnet_id               = var.delegated_subnet_id
  private_dns_zone_id               = var.private_dns_zone_id
  administrator_login               = var.postgres_admin
  administrator_password            = random_password.posgresql_password.result
  sku_name                          = var.posgresql_sku_name
  version                           = var.posgresql_version
  storage_mb                        = var.posgresql_storage_mb
  storage_tier                      = var.posgresql_storage_tier
  backup_retention_days             = var.backup_retention_days
  point_in_time_restore_time_in_utc = var.point_in_time_restore_time_in_utc
  replication_role                  = var.replication_role
  auto_grow_enabled                 = var.auto_grow_enabled
  geo_redundant_backup_enabled      = var.geo_redundant_backup_enabled
  create_mode                       = var.posgresql_create_mode
  public_network_access_enabled     = var.public_network_access_enabled
  source_server_id                  = var.posgresql_source_server_id
  zone                              = var.posgresql_zone
  tags                              = local.tags

  dynamic "timeouts" {
    for_each = var.timeouts != null ? { this = var.timeouts } : {}
    content {
      create = timeouts.value.create
      update = timeouts.value.update
      read   = timeouts.value.read
      delete = timeouts.value.delete
    }
  }

  dynamic "authentication" {
    for_each = var.ad_auth_enabled || var.password_auth_enabled ? { this = true } : {}
    content {
      active_directory_auth_enabled = var.ad_auth_enabled
      password_auth_enabled         = var.password_auth_enabled
      tenant_id                     = data.azurerm_client_config.current.tenant_id
    }
  }

  dynamic "identity" {
    for_each = var.user_assigned_identity_ids != null ? var.user_assigned_identity_ids : {}
    content {
      type         = "UserAssigned"
      identity_ids = [identity.value.identity_id]
    }
  }

  dynamic "customer_managed_key" {
    for_each = var.customer_managed_key != null ? var.customer_managed_key : {}
    content {
      key_vault_key_id                     = customer_managed_key.value.key_vault_key_id
      primary_user_assigned_identity_id    = customer_managed_key.value.primary_user_assigned_identity_id
      geo_backup_key_vault_key_id          = customer_managed_key.value.geo_backup_key_vault_key_id
      geo_backup_user_assigned_identity_id = customer_managed_key.value.geo_backup_user_assigned_identity_id
    }
  }

  dynamic "maintenance_window" {
    for_each = var.maintenance_window != null ? var.maintenance_window : {}
    content {
      day_of_week  = maintenance_window.value.day_of_week
      start_hour   = maintenance_window.value.start_hour
      start_minute = maintenance_window.value.start_minute
    }
  }

  dynamic "high_availability" {
    for_each = var.high_availability != null ? var.high_availability : {}
    content {
      mode                      = high_availability.value.high_availability_mode
      standby_availability_zone = high_availability.value.standby_availability_zone
    }
  }

  lifecycle {
    ignore_changes = [high_availability, zone]
  }
}


resource "azurerm_postgresql_flexible_server_configuration" "postgresql_flexible_config" {
  for_each  = var.postgresql_configurations
  name      = each.key
  server_id = azurerm_postgresql_flexible_server.posgresflexible.id
  value     = each.value
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  name      = var.postgres_db
  server_id = azurerm_postgresql_flexible_server.posgresflexible.id
  collation = var.collation
  charset   = var.charset

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}
