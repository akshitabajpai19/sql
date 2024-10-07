resource_group_name = "testing-rg-postgre"
key_vault_name      = "newkey123"
key_vault_rg_name   = "testing-rg-postgre"
user_assigned_identity_ids = {
  user01 = {
    identity_id = "/subscriptions/XXXXXXXXXXXXXXXXXXXXX/resourceGroups/testing-rg-postgre/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mi-latest"
  }
}
posgresql_server_name  = "akshita-test01"
delegated_subnet_id    = "/subscriptions/XXXXXXXXXXXXXXXXXXXXX/resourceGroups/testing-rg-postgre/providers/Microsoft.Network/virtualNetworks/new-vnet/subnets/new"
private_dns_zone_id    = "/subscriptions/XXXXXXXXXXXXXXXXXXXXX/resourceGroups/testing-rg-postgre/providers/Microsoft.Network/privateDnsZones/vkey.postgres.database.azure.com"
postgres_admin         = "sqladmin"
posgresql_sku_name     = "GP_Standard_D2s_v3"
posgresql_storage_mb   = 65536
posgresql_storage_tier = "P6"
postgres_db            = "new-post-db"
timeouts = {
  create = "1h"
  update = "30m"
  read   = "2m"
  delete = "20m"
}
customer_managed_key = {
  c01 = {
    key_vault_key_id                  = "https://newkey123.vault.azure.net/keys/kv-key-postgre/XXXXXXXXXXXXXXXXXXXXX"
    primary_user_assigned_identity_id = "/subscriptions/XXXXXXXXXXXXXXXXXXXXXX/resourceGroups/testing-rg-postgre/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mi-latest"

  }
}
tags = {
  new_env = "Prod"
}
backup_retention_days        = 7
geo_redundant_backup_enabled = false
posgresql_create_mode        = "Default"
ad_auth_enabled              = true
high_availability = {
  high01 = {
    high_availability_mode = "SameZone"
  }
}

postgresql_configurations = {
  "TimeZone"         = "EST",
  "azure.extensions" = "FUZZYSTRMATCH,PAGEINSPECT,PG_BUFFERCACHE,PG_FREESPACEMAP,PG_PREWARM,PG_STAT_STATEMENTS,PGCRYPTO,PGROWLOCKS,PGSTATTUPLE,UUID-OSSP"
}

location            = "East US"
appid               = "00000000-0000-0000-0000-000000000000"
appname             = "new-app"
env                 = "dev"
costCostCenter      = "123"
costVP              = "356"
costAppOwnerTech    = "new"
costAppOwnerManager = "manager"
costBudgetOwner     = "owner"
costbaseline        = "baseline"
resourcetype        = "resource"
costDivision        = "1363"
costAllocation      = "1234"
appFunction         = "function"
monthlyBudget       = "123456"