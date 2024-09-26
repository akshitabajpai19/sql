resource_group_name  = "post-rg"
key_vault_name       = "kv-postgresql27"
key_vault_rg_name    = "post-rg"
user_assigned_identity_ids = {
  user01 = {
    identity_id = "/subscriptions/25538273-e37b-4758-89b1-d352cdac750c/resourceGroups/post-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/new-mi"
  }
}
posgresql_server_name = "mtjpostsql45"
delegated_subnet_id   = "/subscriptions/25538273-e37b-4758-89b1-d352cdac750c/resourceGroups/rg-test/providers/Microsoft.Network/virtualNetworks/vm-test-vnet/subnets/snet-postsqldb"
private_dns_zone_id   = "/subscriptions/25538273-e37b-4758-89b1-d352cdac750c/resourceGroups/post-rg/providers/Microsoft.Network/privateDnsZones/vkey.postgres.database.azure.com"
postgres_admin        = "sqladmin"
posgresql_sku_name    = "GP_Standard_D2s_v3"
posgresql_storage_mb  = 65536
postgres_db           = "new-post-db"
customer_managed_key = {
  c01 = {
    key_vault_key_id                  = "https://kv-postgresql27.vault.azure.net/keys/kv-key-postgre/88971ddd115549d5b46b7cf604ccfb33"
    primary_user_assigned_identity_id = "/subscriptions/25538273-e37b-4758-89b1-d352cdac750c/resourceGroups/post-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/new-mi"

  }
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
  "TimeZone" = "EST",
  #"log_timezone" = "EST",
  "azure.extensions" = "FUZZYSTRMATCH,PAGEINSPECT,PG_BUFFERCACHE,PG_FREESPACEMAP,PG_PREWARM,PG_STAT_STATEMENTS,PGCRYPTO,PGROWLOCKS,PGSTATTUPLE,UUID-OSSP"
}
