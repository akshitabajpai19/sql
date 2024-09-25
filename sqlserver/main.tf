data "azurerm_resource_group" "this" {
  name  = var.resource_group_name
}

data "azurerm_key_vault" "this" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault" "secondary" {
  count               = var.geo_secondary_key_vault_name != null ? 1 : 0
  name                = var.geo_secondary_key_vault_name
  resource_group_name = var.geo_secondary_key_vault_rg_name
}

# data "azurerm_storage_account" "this" {
#   count               = (var.auditing_storage_account_name != null) ? 1 : 0
#   name                = var.auditing_storage_account_name
#   resource_group_name = var.resource_group_name
# }

# Generate random password
resource "random_password" "this" {
  length           = 32
  min_upper        = 2
  min_lower        = 2
  min_special      = 2
  numeric           = true
  special          = true
  override_special = "!@$%*()-_=+[]{}:?"
}

# -
# - Get the current user config
# -
data "azurerm_client_config" "current" {}

locals {
  tags                       = merge(var.azuresql_additional_tags, data.azurerm_resource_group.this.tags)
  administrator_login_password = var.administrator_login_password == null ? random_password.this.result : var.administrator_login_password

  key_permissions         = ["Get", "WrapKey", "UnwrapKey"]
  secret_permissions      = ["Get"]
  certificate_permissions = ["Get"]
  storage_permissions     = ["Get"]

  zone_redundant = var.sku_name != null ? ((substr(var.sku_name, 0, 2) == "BC" || substr(var.sku_name, 0, 1) == "P") ? true : false) : null
}

# -
# - Azure SQL Server
# -
resource "azurerm_mssql_server" "this" {
  name                         = var.server_name
  resource_group_name          = var.resource_group_name
  location                     = data.azurerm_resource_group.this.location
  version                      = var.azuresql_version
  administrator_login          = var.administrator_login_name
  administrator_login_password = local.administrator_login_password

  # - Azure SQL Allow/Deny Public Network Access
  # - Only private endpoint connections will be allowed to access this resource if "private_endpoint_connection_enabled" variable is set to true
  public_network_access_enabled = var.private_endpoint_connection_enabled ? false : true

  minimum_tls_version = var.minimum_tls_version

  dynamic "identity" {
    for_each = var.assign_identity == false ? [] : tolist([var.assign_identity])
    content {
      type = "SystemAssigned"
    }
  }

  lifecycle {
    ignore_changes = [administrator_login_password]
  }

  tags = local.tags
}

# # -
# # - Create Role Assignment for Azure Sql Server Extended Auditing Policy
# # -
# resource "azurerm_role_assignment" "primary" {
#   count                = var.auditing_storage_account_name != null ? 1 : 0
#   #azurerm_mssql_database.this[count.index].name
#   scope                = data.azurerm_storage_account.this[count.index].id
#   role_definition_name = "Storage Blob Data Contributor"
#   principal_id         = azurerm_mssql_server.this.identity.0.principal_id
#   depends_on           = [azurerm_mssql_server.this]
# }

# # -
# # - Create Azure Sql Server Extended Auditing Policy
# # -
# resource "azurerm_mssql_server_extended_auditing_policy" "primary" {
#   count             = var.auditing_storage_account_name != null ? 1 : 0
#   server_id         = azurerm_mssql_server.this.id
#   storage_endpoint  = data.azurerm_storage_account.this[count.index].primary_blob_endpoint
#   retention_in_days = var.auditing_retention_in_days
#   depends_on        = [azurerm_role_assignment.primary]
# }

# -
# - Azure SQL Databases
# -
resource "azurerm_mssql_database" "this" {
  count     = length(var.database_names)
  name      = element(var.database_names, count.index)
  server_id = azurerm_mssql_server.this.id #added by v-rsrao for review
  collation                   = var.db_collation
  max_size_gb                 = var.max_size_gb
  sku_name                    = var.sku_name
  zone_redundant              = local.zone_redundant
  elastic_pool_id             = var.elastic_pool_id
  create_mode                 = var.create_mode
  creation_source_database_id = var.creation_source_database_id
  restore_point_in_time       = var.restore_point_in_time

  tags       = local.tags
  depends_on = [azurerm_mssql_server.this]
}

# -
# - Update long term retention settings for Azure SQL Database
# -
# resource "null_resource" "this" {
#   count = var.auditing_storage_account_name != null ? length(var.database_names) : 0
#   triggers = {
#     azsql_database_id = azurerm_mssql_database.this[count.index].name
#   }
#   provisioner "local-exec" {
#     command = <<EOT
#       curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
#       az sql db ltr-policy set --resource-group ${var.resource_group_name} --server ${azurerm_mssql_server.this.name} --name ${azurerm_mssql_database.this[count.index].name} --weekly-retention P3W
#     EOT
#   }
#   depends_on = [azurerm_mssql_database.this]
# }

# -
# - Azure SQL Server Virtual Network Rule
# - Enabled only if "private_endpoint_connection_enabled" variable is set to false
# -
resource "azurerm_mssql_virtual_network_rule" "this" {
  count               = var.private_endpoint_connection_enabled == false ? length(var.allowed_networks) : 0
  name                = "azuresql-vnet-rule-${count.index + 1}"
  server_id =  azurerm_mssql_server.this.id
  subnet_id           = var.allowed_networks[count.index].subnet_id #element(data.azurerm_subnet.this, count.index)["id"]
  depends_on          = [azurerm_mssql_server.this]
}

# -
# - Azure SQL Server Firewall Rule
# - Enabled only if "private_endpoint_connection_enabled" variable is set to false
# -
resource "azurerm_mssql_firewall_rule" "this" {
  for_each            = var.private_endpoint_connection_enabled == false ? var.firewall_rules : {}
  name                = each.value.name
  server_id        = azurerm_mssql_server.this.id
  start_ip_address    = each.value.start_ip_address
  end_ip_address      = each.value.end_ip_address
  depends_on          = [azurerm_mssql_server.this]
}

# -
# - Create Key Vault Accesss Policy for Azure SQL MSI
# -
resource "azurerm_key_vault_access_policy" "this" {
  count        = var.assign_identity == true ? 1 : 0
  key_vault_id = data.azurerm_key_vault.this.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_mssql_server.this.identity.0.principal_id

  key_permissions         = local.key_permissions
  secret_permissions      = local.secret_permissions
  certificate_permissions = local.certificate_permissions
  storage_permissions     = local.storage_permissions

  depends_on = [azurerm_mssql_server.this]
}

# -
# - Add Azure SQL Admin Login Password to Key Vault secrets
# -
resource "azurerm_key_vault_secret" "azuresql_keyvault_secret" {
  count        = (var.key_vault_name != null) ? 1 : 0 # newly added code
  name         = azurerm_mssql_server.this.name
  value        = local.administrator_login_password
  key_vault_id = data.azurerm_key_vault.this.id
  depends_on   = [azurerm_mssql_server.this]
}

# -
# - Generate CMK Key for Azure Sql Server
# - Grant Key Vault permissions to your server
# - 
resource "azurerm_key_vault_key" "primary" {
  count        = var.cmk_enabled_transparent_data_encryption == true ? 1 : 0
  name         = format("%s-key", azurerm_mssql_server.this.name)
  key_vault_id = data.azurerm_key_vault.this[count.index].id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt", "encrypt", "sign",
    "wrapKey", "verify", "unwrapKey"
  ]
}

# -
# - Add the Key Vault key to the server and set the TDE Protector
# - Turn on TDE (Transparent Data Encryption)
# - 
resource "null_resource" "cmk_primary" {
  count = var.cmk_enabled_transparent_data_encryption == true ? length(var.database_names) : 0
  triggers = {
    azsql_database_id = azurerm_mssql_database.this[count.index].name
  }
  provisioner "local-exec" {
    command = <<EOT
      az sql server key create --server ${azurerm_mssql_server.this.name} --resource-group ${var.resource_group_name} --kid ${azurerm_key_vault_key.primary.0.id}
      sleep 2m
      az sql server tde-key set --server ${azurerm_mssql_server.this.name} --server-key-type AzureKeyVault  --resource-group ${var.resource_group_name} --kid ${azurerm_key_vault_key.primary.0.id}
      az sql db tde set --database ${azurerm_mssql_database.this[count.index].name} --resource-group ${var.resource_group_name} --server ${azurerm_mssql_server.this.name} --status Enabled
    EOT
  }
  depends_on = [azurerm_mssql_server.this, azurerm_mssql_database.this, azurerm_mssql_failover_group.this]
}

# -
# - Assigning Reader Role to Azure SQL MSI
# -
resource "azurerm_role_assignment" "cmk_primary" {
  count                            = var.cmk_enabled_transparent_data_encryption == true ? 1 : 0
  scope                            = data.azurerm_key_vault.this[count.index].id
  role_definition_name             = "Key Vault Contributor"
  principal_id                     = azurerm_mssql_server.this.identity.0.principal_id
  skip_service_principal_aad_check = true
  depends_on                       = [azurerm_mssql_server.this]
}

# -
# - Secondary/Failover Azure SQL Server
# -
resource "azurerm_mssql_server" "sqlserver_secondary" {
  count                        = var.enable_failover_server ? 1 : 0
  name                         = "${var.server_name}-secondary" #"${local.name}-secondary"
  resource_group_name          = var.resource_group_name
  location                     = var.failover_location
  version                      = var.azuresql_version
  administrator_login          = var.administrator_login_name
  administrator_login_password = local.administrator_login_password

  # - Azure SQL Allow/Deny Public Network Access
  # - Only private endpoint connections will be allowed to access this resource if "private_endpoint_connection_enabled" variable is set to true
  public_network_access_enabled = var.private_endpoint_connection_enabled ? false : true

  minimum_tls_version = var.minimum_tls_version

  lifecycle {
    ignore_changes = [administrator_login_password]
  }

  dynamic "identity" {
    for_each = var.assign_identity == false ? [] : tolist([var.assign_identity])
    content {
      type = "SystemAssigned"
    }
  }

  tags = local.tags
}

# -
# - Azure SQL Server Failover Group
# -
resource "azurerm_mssql_failover_group" "this" {
  count               = var.enable_failover_server ? 1 : 0
  name                = "${var.server_name}-failover-group"
  server_id         = azurerm_mssql_server.this.id
  databases           = azurerm_mssql_database.this.*.id
  partner_server {
    id = azurerm_mssql_server.sqlserver_secondary.0.id
  }

  read_write_endpoint_failover_policy {
    mode          = coalesce(var.read_write_endpoint_failover_policy_mode, "Automatic")
    grace_minutes = coalesce(var.read_write_endpoint_failover_policy_mode, "Automatic") == "Automatic" ? 60 : null
  }

  depends_on = [azurerm_mssql_database.this, azurerm_mssql_server.this, azurerm_mssql_server.sqlserver_secondary]
}

# -
# - Create Role Assignment for Secondary Azure Sql Server Extended Auditing Policy
# -
# resource "azurerm_role_assignment" "secondary" {
#   count                = (var.enable_failover_server == true && var.auditing_storage_account_name != null) ? 1 : 0
#   scope                = data.azurerm_storage_account.this[count.index].id
#   role_definition_name = "Storage Blob Data Contributor"
#   principal_id         = azurerm_mssql_server.sqlserver_secondary.0.identity.0.principal_id
#   depends_on           = [azurerm_mssql_server.sqlserver_secondary]
# }

# -
# - Create Secondary Azure Sql Server Extended Auditing Policy
# -
# resource "azurerm_mssql_server_extended_auditing_policy" "secondary" {
#   count             = (var.enable_failover_server == true && var.auditing_storage_account_name != null) ? 1 : 0
#   server_id         = azurerm_mssql_server.sqlserver_secondary.0.id
#   storage_endpoint  = data.azurerm_storage_account.this[count.index].primary_blob_endpoint
#   retention_in_days = var.auditing_retention_in_days
#   depends_on        = [azurerm_mssql_failover_group.this]
# }

# -
# - Create Key Vault Accesss Policy for Secondary Azure SQL MSI
# -
resource "azurerm_key_vault_access_policy" "secondary" {
  count        = (var.enable_failover_server == true && var.assign_identity == true && var.geo_secondary_key_vault_name != null) ? 1 : 0
  key_vault_id = data.azurerm_key_vault.secondary.0.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_mssql_server.sqlserver_secondary.0.identity.0.principal_id

  key_permissions         = local.key_permissions
  secret_permissions      = local.secret_permissions
  certificate_permissions = local.certificate_permissions
  storage_permissions     = local.storage_permissions

  depends_on = [azurerm_mssql_server.sqlserver_secondary]
}

# -
# - Backup/Restore CMK Key for Secondary Azure Sql Server
# - Add the Key Vault key to the server and set the TDE Protector
# - Turn on TDE (Transparent Data Encryption)
# - 
resource "null_resource" "cmk_secondary" {
  count = (var.enable_failover_server == true && var.geo_secondary_key_vault_name != null && var.cmk_enabled_transparent_data_encryption == true) ? length(var.database_names) : 0
  triggers = {
    azsql_database_id = azurerm_mssql_database.this[count.index].name
  }
  provisioner "local-exec" {
    command = <<EOT
      az keyvault key backup --file ${format("%s-key.keybackup", azurerm_mssql_server.this.name)} --name ${format("%s-key", azurerm_mssql_server.this.name)} --vault-name ${data.azurerm_key_vault.this[count.index].name}
      az keyvault key restore --file ${format("%s-key.keybackup", azurerm_mssql_server.this.name)} --vault-name ${data.azurerm_key_vault.secondary.0.name}
      kid=$(az keyvault key show --name ${format("%s-key", azurerm_mssql_server.this.name)} --vault-name ${data.azurerm_key_vault.secondary.0.name} --query 'key.kid' -o tsv)
      az sql server key create --server ${azurerm_mssql_server.sqlserver_secondary.0.name} --resource-group ${var.resource_group_name} --kid $kid
      az sql server tde-key set --server ${azurerm_mssql_server.sqlserver_secondary.0.name} --server-key-type AzureKeyVault  --resource-group ${var.resource_group_name} --kid $kid      
    EOT
  }
  depends_on = [azurerm_mssql_failover_group.this, azurerm_mssql_server.sqlserver_secondary, azurerm_mssql_server.this, azurerm_mssql_database.this]
}

# -
# - Assigning Reader Role to Secondary Azure SQL MSI
# -
resource "azurerm_role_assignment" "cmk_secondary" {
  count                            = (var.enable_failover_server == true && var.geo_secondary_key_vault_name != null && var.cmk_enabled_transparent_data_encryption == true) ? 1 : 0
  scope                            = data.azurerm_key_vault.secondary.0.id
  role_definition_name             = "Key Vault Contributor"
  principal_id                     = azurerm_mssql_server.sqlserver_secondary.0.identity.0.principal_id
  skip_service_principal_aad_check = true
  depends_on                       = [azurerm_mssql_server.sqlserver_secondary]
}
