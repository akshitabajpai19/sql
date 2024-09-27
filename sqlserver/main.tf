# Generate random password
resource "random_password" "this" {
  length           = 32
  min_upper        = 2
  min_lower        = 2
  min_special      = 2
  numeric          = true
  special          = true
  override_special = "!@$%*()-_=+[]{}:?"
}


# - Azure SQL Server
# -
resource "azurerm_mssql_server" "this" {
  for_each                                     = var.sql_servers
  name                                         = each.value["name"]
  resource_group_name                          = each.value["resource_group_name"]
  location                                     = each.value["location"]
  version                                      = each.value["version"]
  administrator_login                          = each.value["administrator_login_name"]
  administrator_login_password                 = random_password.this.result
  connection_policy                            = each.value["connection_policy"]
  transparent_data_encryption_key_vault_key_id = each.value["transparent_data_encryption_key_vault_key_id"]
  public_network_access_enabled                = each.value["public_network_access_enabled"]
  minimum_tls_version                          = each.value["minimum_tls_version"]
  outbound_network_restriction_enabled         = each.value["outbound_network_restriction_enabled"]
  primary_user_assigned_identity_id            = each.value["primary_user_assigned_identity_id"]


  dynamic "identity" {
    for_each = var.identity != null ? var.identity : {}
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "azuread_administrator" {
    for_each = var.azuread_administrator != null ? var.azuread_administrator : {}
    content {
      login_username              = azuread_administrator.value.login_username
      object_id                   = azuread_administrator.value.object_id
      tenant_id                   = azuread_administrator.value.tenant_id
      azuread_authentication_only = azuread_administrator.value.azuread_authentication_only
    }

  }

  lifecycle {
    ignore_changes = [administrator_login_password]
  }

  tags = merge(each.value["tags"], local.tags)
}
