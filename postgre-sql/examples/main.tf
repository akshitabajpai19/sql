module "postgre-deploy" {
  source                            = "../"
  resource_group_name               = var.resource_group_name
  key_vault_name                    = var.key_vault_name
  key_vault_rg_name                 = var.key_vault_rg_name
  user_assigned_identity_ids        = var.user_assigned_identity_ids
  posgresql_server_name             = var.posgresql_server_name
  delegated_subnet_id               = var.delegated_subnet_id
  private_dns_zone_id               = var.private_dns_zone_id
  postgres_admin                    = var.postgres_admin
  posgresql_sku_name                = var.posgresql_sku_name
  posgresql_storage_mb              = var.posgresql_storage_mb
  posgresql_storage_tier            = var.posgresql_storage_tier
  backup_retention_days             = var.backup_retention_days
  geo_redundant_backup_enabled      = var.geo_redundant_backup_enabled
  posgresql_create_mode             = var.posgresql_create_mode
  posgresql_source_server_id        = var.posgresql_source_server_id
  public_network_access_enabled     = var.public_network_access_enabled
  password_auth_enabled             = var.password_auth_enabled
  ad_auth_enabled                   = var.ad_auth_enabled
  point_in_time_restore_time_in_utc = var.point_in_time_restore_time_in_utc
  maintenance_window                = var.maintenance_window
  high_availability                 = var.high_availability
  auto_grow_enabled                 = var.auto_grow_enabled
  posgresql_version                 = var.posgresql_version
  replication_role                  = var.replication_role
  timeouts                          = var.timeouts
  posgresql_zone                    = var.posgresql_zone
  kv_secret_content_type            = var.kv_secret_content_type
  kv_secret_expiration_date         = var.kv_secret_expiration_date
  customer_managed_key              = var.customer_managed_key
  postgresql_configurations         = var.postgresql_configurations
  charset                           = var.charset
  collation                         = var.collation
  postgres_db                       = var.postgres_db
  tags                              = var.tags
  location                          = var.location
  appid                             = var.appid
  appname                           = var.appname
  env                               = var.env
  costCostCenter                    = var.costCostCenter
  costVP                            = var.costVP
  costAppOwnerTech                  = var.costAppOwnerTech
  costAppOwnerManager               = var.costAppOwnerManager
  costBudgetOwner                   = var.costBudgetOwner
  costbaseline                      = var.costbaseline
  resourcetype                      = var.resourcetype
  costDivision                      = var.costDivision
  costAllocation                    = var.costAllocation
  appFunction                       = var.appFunction
  monthlyBudget                     = var.monthlyBudget
}
