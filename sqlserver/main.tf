
data "azurerm_key_vault" "sql_server_key_vault" {
  for_each = {
    for key, value in var.sql_servers : key => value
    if try(value.administrator_login_name, null) != null
  }
  name                = lookup(each.value, "sql_server_keyvault_name", null)
  resource_group_name = lookup(each.value, "sql_server_keyvault_rg_name", null)
}

resource "random_string" "username" {
  for_each = {
    for key, value in var.sql_servers : key => value
    if try(value.administrator_login_name, null) != null
  }
  length  = 20
  special = false
}

# Generate random password
resource "random_password" "this" {
  for_each = {
    for key, value in var.sql_servers : key => value
    if try(value.administrator_login_name, null) != null
  }
  length           = 32
  min_upper        = 2
  min_lower        = 2
  min_special      = 2
  numeric          = true
  special          = true
  override_special = "!@$%*()-_=+[]{}:?"
}

resource "azurerm_key_vault_secret" "sql_pwd" {
  for_each = {
    for key, value in var.sql_servers : key => value
    if try(value.administrator_login_name, null) != null
  }
  name            = "${each.value.name}-${local.naming}-pwd-${each.value.additionalcontext}" #to be used
  value           = random_password.this[each.key].result
  key_vault_id    = data.azurerm_key_vault.sql_server_key_vault[each.key].id
  content_type    = "Azure USER PASS secret" #${var.appname} to be added as each.value
  expiration_date = timeadd(timestamp(), "8760h")
  tags = {
    type     = "username",
    username = random_string.username[each.key].result
  }
}

# - Azure SQL Server
# -
resource "azurerm_mssql_server" "this" {
  for_each                                     = var.sql_servers
  name                                         = each.value["name"]
  resource_group_name                          = each.value["sql_server_resource_group_name"]
  location                                     = each.value["location"]
  version                                      = each.value["version"]
  administrator_login                          = each.value["administrator_login_name"]
  administrator_login_password                 = try(random_password.this[each.key].result, null)
  connection_policy                            = each.value["connection_policy"]
  transparent_data_encryption_key_vault_key_id = each.value["transparent_data_encryption_key_vault_key_id"]
  public_network_access_enabled                = each.value["public_network_access_enabled"]
  minimum_tls_version                          = each.value["minimum_tls_version"]
  outbound_network_restriction_enabled         = each.value["outbound_network_restriction_enabled"]
  primary_user_assigned_identity_id            = each.value["primary_user_assigned_identity_id"]


  dynamic "identity" {
    for_each = each.value.identity != null ? each.value.identity : {}
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "azuread_administrator" {
    for_each = each.value.azuread_administrator != null ? each.value.azuread_administrator : {}
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

  tags = merge(each.value["tags"], local.mandatory_tags)
}

data "azurerm_mssql_server" "this" {
  for_each            = var.sql_servers
  name                = each.value["name"]
  resource_group_name = each.value["sql_server_resource_group_name"]
  depends_on          = [azurerm_mssql_server.this]
}


module "private-endpoint-setup" {
  source                         = "../private-endpoint"
  for_each                       = var.sql_server_private_endpoints
  domain_name                    = each.value.domain_name
  resource_group_name            = each.value.private_endpoint_resource_group_name
  a_records                      = each.value.a_records
  aaaa_records                   = each.value.aaaa_records
  cname_records                  = each.value.cname_records
  enable_telemetry               = each.value.enable_telemetry
  mx_records                     = each.value.mx_records
  ptr_records                    = each.value.ptr_records
  soa_record                     = each.value.soa_record
  srv_records                    = each.value.srv_records
  tags                           = merge(each.value["tags"], local.mandatory_tags)
  txt_records                    = each.value.txt_records
  virtual_network_links          = each.value.virtual_network_links
  private_endpoints              = each.value.private_endpoints
  location                       = each.value.location
  subscription_id                = each.value.subscription_id
  virtual_network_rg             = each.value.virtual_network_rg
  virtual_network_name           = each.value.virtual_network_name
  pe_subnet_name                 = each.value.pe_subnet_name
  private_connection_resource_id = lookup(data.azurerm_mssql_server.this, each.value["sql_server_key"], null)["id"]
  dns_zone_id                    = each.value.dns_zone_id
  create_dns_zone                = each.value.create_dns_zone
  additionalcontext              = each.value.additionalcontext
  depends_on                     = [azurerm_mssql_server.this]
}
