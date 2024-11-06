create_resource_group                = true
enable_telemetry                     = true
resource_group_name                  = "avmModuleTesting2"
location                             = "EastUS"
recovery_services_vault_name         = "testrecoveryvaulteus"
key_vault_name                       = "testkvLu110"
key_vault_rg_name                    = "test-rg18"
key_vault_key_name                   = "test-key"
kv_role_definition                   = "Key Vault Crypto Officer"
recovery_vault_public_access_enabled = false
enable_encryption                    = true
enable_private_endpoint              = true
recovery_vault_identity_type         = "SystemAssigned"
# user_assigned_identity_rg_name       = "test-rg18" ##Should be provided if the recovery_vault_identity_type = "UserAssigned"
# existing_user_assigned_identity_name = "testuseridentity046" ##Should be provided if the recovery_vault_identity_type = "UserAssigned"
vm_backup_policies = {
  "test-whg-db-bkp-01" = {
    name                           = "test-whg-db-bkp-01"
    policy_type                    = "V2"
    timezone                       = "Eastern Standard Time"
    instant_restore_retention_days = 5
    frequency                      = "Daily"
    time                           = "02:00"
    daily = [{
      count = 30
    }]
    weekly = [{
      count    = 4
      weekdays = ["Sunday"]
    }]
    monthly = [{
      count    = 6
      weekdays = ["Sunday"]
      weeks    = ["First"]
    }]
    yearly = [{
      count    = 1
      months   = ["January"]
      weekdays = ["Sunday"]
      weeks    = ["First"]
    }]
  }
}

private_endpoints = {
  "pe1" = {
    name                 = "private-endpoint-23"
    subresource_names    = ["AzureSiteRecovery"]
    is_manual_connection = false
  }
}
# Azure Subscription ID
subscription_id = ""

# Virtual Network Details
virtual_network_rg   = "test-rg18"
virtual_network_name = "testvnet58"
pe_subnet_name       = "default"
dns_zone_id          = ""
create_dns_zone      = true
tags = {
  Environment = "Development"
  Department  = "IT"
}
diagnostics_settings_name = "test-diag1"
domain_name               = "test.project.com"
logs_destinations_ids     = [""]
enable_diagnostic_setting = true
virtual_network_links = {
  "test-vnet-link" = {
    vnetlinkname = "test-vnet-link5"
    vnetid       = ""
  }
}

# Tag variable values
resourcetype        = "rsv"
appid               = "ap01"
appname             = "infra"
env                 = "dev"
costcostcenter      = "test"
costvp              = "VP"
costappownertech    = "owner"
costappownermanager = "Manager"
costbudgetowner     = "budget owner"
costdivision        = "IT"
appfunction         = "exmaple general Prod Subscription"
costbaseline        = "2024"
costallocation      = "sharedcost"
monthlybudget       = "1000"
managed_by          = "own"
additionalcontext   = "01"