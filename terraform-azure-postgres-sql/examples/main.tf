resource "azurerm_subnet" "example" {
  name                 = "vkdemo-snet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}
data "azurerm_private_dns_zone" "this" {
  name                = "vkey.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}
module "postgre-deploy" {
  source                       = "../terraform-azure-postgres-sql"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = var.virtual_network_name
  key_vault_name               = var.key_vault_name
  key_vault_rg_name            = var.key_vault_rg_name
  enable_encryption            = var.enable_encryption
  key_vault_key_name           = var.key_vault_key_name
  user_assigned_identity_ids   = var.user_assigned_identity_ids
  posgresql_server_name        = var.posgresql_server_name
  delegated_subnet_id          = azurerm_subnet.example.id
  private_dns_zone_id          = var.private_dns_zone_id #data.azurerm_private_dns_zone.example.id 
  postgres_admin               = var.postgres_admin
  posgresql_sku_name           = var.posgresql_sku_name
  posgresql_storage_mb         = var.posgresql_storage_mb
  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  posgresql_create_mode        = var.posgresql_create_mode
  ad_auth_enabled              = var.ad_auth_enabled
  high_availability            = var.high_availability
  enable_diagnostics           = var.enable_diagnostics
  diagnostics_settings_name    = var.diagnostics_settings_name
  postgresql_configurations    = var.postgresql_configurations
  postgres_db                  = var.postgres_db
  tags                         = var.tags
}

