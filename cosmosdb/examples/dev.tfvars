cosmosdb = {
  c01 = {
    location                           = "centralus"
    resource_group_name                = "new-rg"
    db_type                            = null
    enable_telemetry                   = true
    access_key_metadata_writes_enabled = true
    analytical_storage_config          = null
    analytical_storage_enabled         = false
    automatic_failover_enabled         = false
    backup                             = {}
    capabilities                       = []
    capacity                           = {}
    consistency_policy                 = {}
    cors_rule                          = null
    customer_managed_key               = null
    diagnostic_settings                = {}
    enable_telemetry                   = true
    free_tier_enabled                  = false
    geo_locations = [
      {
        location          = "centralus"
        failover_priority = 0
        zone_redundant    = false
      }
    ]
    ip_range_filter                         = []
    local_authentication_disabled           = false
    lock                                    = null
    managed_identities                      = { system_assigned = false, user_assigned = [] }
    minimal_tls_version                     = "Tls12"
    mongo_databases                         = null
    multiple_write_locations_enabled        = false
    network_acl_bypass_for_azure_services   = false
    network_acl_bypass_ids                  = []
    partition_merge_enabled                 = false
    private_endpoints                       = {}
    private_endpoints_manage_dns_zone_group = true
    public_network_access_enabled           = true
    role_assignments                        = {}
    sql_databases                           = {}
    sql_dedicated_gateway                   = null
    tags = {
      environment = "dev"
      project     = "newapp"
    }
    virtual_network_rules = []

  }
}


cosmosdb_pgsql = {
  pg01 = {
    name                                 = "post-cosmos"
    resource_group_name                  = "new-rg"
    location                             = "eastus"
    node_count                           = 2
    citus_version                        = "10.0"
    coordinator_public_ip_access_enabled = true
    coordinator_server_edition           = "GeneralPurpose"
    coordinator_storage_quota_in_mb      = 524288
    coordinator_vcore_count              = 4
    ha_enabled                           = true
    node_public_ip_access_enabled        = false
    node_server_edition                  = "MemoryOptimized"
    node_storage_quota_in_mb             = 524288
    cosmos_key                           = "c01"
    node_vcores                          = 2
    point_in_time_in_utc                 = null
    preferred_primary_zone               = "1"
    shards_on_coordinator_enabled        = false
    # source_location                      = null
    # source_resource_id                   = null
    sql_version = 12
    tags = {
      environment = "dev"
      project     = "example-project"
    }
    maintenance_window = {
      day_of_week  = 6
      start_hour   = "3"
      start_minute = "0"
    }
    timeouts = {
      create = "3h"
      delete = "5m"
      read   = "3h"
      update = "3h"
    }
  }

}
db_type             = null
key_vault_name      = "key0019"
key_vault_rg_name   = "new-rg"
location            = "westeurope"
appid               = "t0000000"
appname             = "newapp"
env                 = "dev"
costAppOwnerTech    = "new"
costAppOwnerManager = "manager"
costBudgetOwner     = "owner"
costbaseline        = "baseline"
resourcetype        = "resource"
costDivision        = "t363"
costAllocation      = "t234"
appFunction         = "function"
monthlyBudget       = "yh23456"
costCostCenter      = "hjbd"
costVP              = "sjdhcj"
additionalcontext   = "01"
