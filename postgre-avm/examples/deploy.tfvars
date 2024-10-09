resource_group_name = "post-rg"
location            = "Central US"
key_vault_name      = "kv-postgresql22"
key_vault_rg_name   = "post-rg"
managed_identities = {
  system_assigned            = false
  user_assigned_resource_ids = ["/subscriptions/XXXXXXXXXXXXXXXX/resourceGroups/post-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/new-mi"]
}

posgresql_server_name = "akshita-test01"
administrator_login   = "sqladmin"
sku_name              = "GP_Standard_D2s_v3"
storage_mb            = 65536
databases = {
  database01 = {
    charset             = "UTF8"
    collation           = "en_US.utf8"
    name                = "new-postgre-db"
    server_name         = "akshita-test01"
    resource_group_name = "post-rg"
  }
}
server_version               = 12
backup_retention_days        = 7
geo_redundant_backup_enabled = false
create_mode                  = "Default"
authentication = {
  active_directory_auth_enabled = true
}

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
