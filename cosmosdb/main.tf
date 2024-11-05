locals {
  naming = replace(replace("${var.resourcetype}${var.appname}${var.env}${var.location}-${var.additionalcontext}", " ", "-"), "[^a-zA-Z0-9-]", "")

  mandatory_tags = {
    appid               = var.appid
    appname             = var.appname
    resourcetype        = var.resourcetype
    costAppOwnerManager = var.costAppOwnerManager
    costAppOwnerTech    = var.costAppOwnerTech
    costBudgetOwner     = var.costBudgetOwner
    costCostCenter      = var.costCostCenter
    costDivision        = var.costDivision
    costRegion          = var.location
    costVP              = var.costVP
    environment         = var.env
    costAllocation      = var.costAllocation
    appFunction         = var.appFunction
    monthlyBudget       = var.monthlyBudget
    costbaseline        = var.costbaseline
    provisioned_by      = "Terraform"
    provisioned_date    = timestamp()
  }

  tags = {
    for key, value in var.cosmosdb_pgsql : key => merge(value.tags, local.mandatory_tags)
  }
  filtered_cosmosdb = {
    for k, v in var.cosmosdb : k => v if v.db_type != "PostgreSQL"
  }

}


#########################################
# Data sources
#########################################

data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg_name
}

#########################################
# Resource Creation : Random password 
#########################################
resource "random_password" "administrator_password" {
  for_each         = var.cosmosdb_pgsql
  length           = 12
  lower            = true
  min_lower        = 2
  min_numeric      = 2
  min_special      = 2
  min_upper        = 2
  override_special = "_"
  special          = true
  upper            = true
}

#---------------------------------------------------------------
# Resource Creation: KeyVault Secret to store admin passwords
#---------------------------------------------------------------
resource "azurerm_key_vault_secret" "this" {
  for_each        = var.cosmosdb_pgsql
  name            = "${replace(each.value.name, "/[^a-zA-Z0-9-]/", "")}-password"
  value           = random_password.administrator_password[each.key].result
  key_vault_id    = data.azurerm_key_vault.kv.id
  content_type    = "PostgreSQL password"
  expiration_date = timeadd(timestamp(), "8760h")
}

module "avm-res-documentdb-databaseaccount" {
  source  = "Azure/avm-res-documentdb-databaseaccount/azurerm"
  version = "0.4.0"

  for_each = local.filtered_cosmosdb

  location            = each.value.location
  name                = local.naming
  resource_group_name = each.value.resource_group_name

  #optional variables
  access_key_metadata_writes_enabled      = try(each.value.access_key_metadata_writes_enabled) != null ? each.value.access_key_metadata_writes_enabled : false
  analytical_storage_config               = try(each.value.analytical_storage_config, null)
  analytical_storage_enabled              = try(each.value.analytical_storage_enabled) != null ? each.value.analytical_storage_enabled : false
  automatic_failover_enabled              = try(each.value.automatic_failover_enabled) != null ? each.value.automatic_failover_enabled : true
  backup                                  = try(each.value.backup) != null ? each.value.backup : {}
  capabilities                            = try(each.value.capabilities) != null ? each.value.capabilities : []
  capacity                                = try(each.value.capacity) != null ? each.value.capacity : {}
  consistency_policy                      = try(each.value.consistency_policy) != null ? each.value.consistency_policy : {}
  cors_rule                               = try(each.value.cors_rule, null)
  customer_managed_key                    = try(each.value.customer_managed_key, null)
  diagnostic_settings                     = try(each.value.diagnostic_settings) != null ? each.value.diagnostic_settings : {}
  enable_telemetry                        = try(each.value.enable_telemetry) != null ? each.value.enable_telemetry : true
  free_tier_enabled                       = try(each.value.free_tier_enabled) != null ? each.value.free_tier_enabled : false
  geo_locations                           = try(each.value.geo_locations, null)
  ip_range_filter                         = try(each.value.ip_range_filter) != null ? each.value.ip_range_filter : []
  local_authentication_disabled           = try(each.value.local_authentication_disabled) != null ? each.value.local_authentication_disabled : false
  lock                                    = try(each.value.lock, null)
  managed_identities                      = try(each.value.managed_identities, { system_assigned = false, user_assigned = [] })
  minimal_tls_version                     = try(each.value.minimal_tls_version) != null ? each.value.minimal_tls_version : "Tls12"
  mongo_databases                         = try(each.value.mongo_databases, null)
  mongo_server_version                    = try(each.value.mongo_server_version) != null ? each.value.mongo_server_version : "3.6"
  multiple_write_locations_enabled        = try(each.value.multiple_write_locations_enabled) != null ? each.value.multiple_write_locations_enabled : false
  network_acl_bypass_for_azure_services   = try(each.value.network_acl_bypass_for_azure_services) != null ? each.value.network_acl_bypass_for_azure_services : false
  network_acl_bypass_ids                  = try(each.value.network_acl_bypass_ids) != null ? each.value.network_acl_bypass_ids : []
  partition_merge_enabled                 = try(each.value.partition_merge_enabled) != null ? each.value.partition_merge_enabled : false
  private_endpoints                       = try(each.value.private_endpoints) != null ? each.value.private_endpoints : {}
  private_endpoints_manage_dns_zone_group = try(each.value.private_endpoints_manage_dns_zone_group) != null ? each.value.private_endpoints_manage_dns_zone_group : true
  public_network_access_enabled           = try(each.value.public_network_access_enabled) != null ? each.value.public_network_access_enabled : true
  role_assignments                        = try(each.value.role_assignments) != null ? each.value.role_assignments : {}
  sql_databases                           = try(each.value.sql_databases) != null ? each.value.sql_databases : {}
  sql_dedicated_gateway                   = try(each.value.sql_dedicated_gateway, null)
  tags                                    = merge(each.value.tags, local.mandatory_tags)
  virtual_network_rules                   = try(each.value.virtual_network_rules) != null ? each.value.virtual_network_rules : []
}

resource "azurerm_cosmosdb_postgresql_cluster" "cosmosdb_pgsql" {
  for_each                        = { for k, v in var.cosmosdb_pgsql : k => v if var.db_type == "PostgreSQL" }
  name                            = each.value["name"]
  resource_group_name             = each.value["resource_group_name"]
  location                        = each.value["location"]
  node_count                      = each.value["node_count"]
  citus_version                   = each.value["citus_version"]
  administrator_login_password    = each.value["source_resource_id"] == null ? random_password.administrator_password[each.key].result : null
  coordinator_vcore_count         = each.value["coordinator_vcore_count"]
  coordinator_storage_quota_in_mb = each.value["coordinator_storage_quota_in_mb"]
  ha_enabled                      = each.value["ha_enabled"]
  node_public_ip_access_enabled   = each.value["node_public_ip_access_enabled"]
  node_server_edition             = each.value["node_server_edition"]
  node_storage_quota_in_mb        = each.value["node_storage_quota_in_mb"]
  node_vcores                     = each.value["node_vcores"]
  point_in_time_in_utc            = each.value["point_in_time_in_utc"]
  preferred_primary_zone          = each.value["preferred_primary_zone"]
  shards_on_coordinator_enabled   = each.value["shards_on_coordinator_enabled"]
  source_location                 = each.value.source_location
  source_resource_id              = each.value.source_resource_id
  sql_version                     = each.value["sql_version"]
  tags                            = local.tags[each.key]

  dynamic "maintenance_window" {
    for_each = each.value.maintenance_window != null ? [each.value.maintenance_window] : []

    content {
      day_of_week  = maintenance_window.value.day_of_week
      start_hour   = maintenance_window.value.start_hour
      start_minute = maintenance_window.value.start_minute
    }
  }
  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
}
