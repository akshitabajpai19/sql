database_names = {
  database01 = {
    server_resource_group_name  = "rg-test"
    name                        = "azuresqldb08102021c"
    sql_server_name             = "jstartall09132021azsqlb"
    sku_name                    = "S0"
    max_size_gb                 = 2
    elastic_pool_id             = null
    create_mode                 = null
    creation_source_database_id = null
    restore_point_in_time       = null
    tags = {
      new  = "tags"
      test = "new"
    }
  }

  database02 = {
    server_resource_group_name          = "rg-test"
    name                                = "new-db"
    sql_server_name                     = "jstartall09132021azsqlb"
    collation                           = "SQL_Latin1_General_CP1_CI_AS"
    sku_name                            = "S0"
    max_size_gb                         = 2
    zone_redundant                      = false
    elastic_pool_id                     = null
    create_mode                         = null
    creation_source_database_id         = null
    restore_point_in_time               = null
    auto_pause_delay_in_minutes         = 10
    enclave_type                        = "Default"
    geo_backup_enabled                  = false
    maintenance_configuration_name      = "SQL_Default"
    ledger_enabled                      = false
    license_type                        = "LicenseIncluded"
    read_replica_count                  = 1
    sample_name                         = "AdventureWorksLT"
    storage_account_type                = "Geo"
    transparent_data_encryption_enabled = true
    tags = {
      new  = "tags"
      test = "new"
    }
  }
}
location            = "Central India"
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
additionalcontext   = "01"