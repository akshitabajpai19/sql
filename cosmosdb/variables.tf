variable "key_vault_name" {
  type        = string
  description = "Name of the keyvault to store admin password"
}

variable "key_vault_rg_name" {
  type        = string
  description = "Resource group name for key vault"
}

variable "kv_secret_content_type" {
  description = "(Optional) Specifies the content type for the Key Vault Secret."
  default     = null
  type        = string
}

variable "kv_secret_expiration_date" {
  description = "(Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."
  default     = null
  type        = string
}

variable "cosmosdb" {
  description = "Cosmosdb configurations for account creation"
  type = map(object({
    location            = string
    name                = optional(string)
    resource_group_name = string
    db_type             = string
    enable_telemetry    = optional(bool, true)
    tags                = optional(map(string), {})
    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      delegated_managed_identity_resource_id = optional(string, null)

      principal_type    = optional(string, null) # forced to be here by lint, not supported
      condition         = optional(string, null) # forced to be here by lint, not supported
      condition_version = optional(string, null) # forced to be here by lint, not supported
    })), {})
    private_endpoints_manage_dns_zone_group = optional(bool, true)
    private_endpoints = optional(map(object({
      subnet_resource_id = string
      subresource_name   = string

      name                                    = optional(string, null)
      private_dns_zone_group_name             = optional(string, "default")
      private_dns_zone_resource_ids           = optional(set(string), [])
      application_security_group_associations = optional(map(string), {})
      private_service_connection_name         = optional(string, null)
      network_interface_name                  = optional(string, null)
      location                                = optional(string, null)
      resource_group_name                     = optional(string, null)

      ip_configurations = optional(map(object({
        name               = string
        private_ip_address = string
      })), {})

      tags = optional(map(string), null)

      lock = optional(object({
        kind = string
        name = optional(string, null)
      }), null)

      role_assignments = optional(map(object({
        role_definition_id_or_name = string
        principal_id               = string

        description                            = optional(string, null)
        skip_service_principal_aad_check       = optional(bool, false)
        delegated_managed_identity_resource_id = optional(string, null)

        principal_type    = optional(string, null) # forced to be here by lint, not supported
        condition         = optional(string, null) # forced to be here by lint, not supported
        condition_version = optional(string, null) # forced to be here by lint, not supported
      })), {})
    })), {})
    mongo_server_version = optional(string, "3.6")
    mongo_databases = optional(map(object({
      name = string

      throughput = optional(number, null)

      autoscale_settings = optional(object({
        max_throughput = number
      }), null)

      collections = optional(map(object({
        name = string

        default_ttl_seconds = optional(string, null)
        shard_key           = optional(string, null)
        throughput          = optional(number, null)

        autoscale_settings = optional(object({
          max_throughput = number
        }), null)

        index = optional(object({
          keys   = list(string)
          unique = optional(bool, false)
        }), null)

      })), {})
    })), {})
    managed_identities = optional(object({
      system_assigned            = optional(bool, false)
      user_assigned_resource_ids = optional(set(string), [])
    }), {})
    lock = optional(object({
      kind = string
      name = optional(string, null)
    }), null)
    diagnostic_settings = optional(map(object({
      name                                     = optional(string, null)
      log_categories                           = optional(set(string), [])
      log_groups                               = optional(set(string), ["allLogs"])
      metric_categories                        = optional(set(string), ["AllMetrics"])
      log_analytics_destination_type           = optional(string, "Dedicated")
      workspace_resource_id                    = optional(string, null)
      storage_account_resource_id              = optional(string, null)
      event_hub_authorization_rule_resource_id = optional(string, null)
      event_hub_name                           = optional(string, null)
      marketplace_partner_resource_id          = optional(string, null)
    })), {})
    customer_managed_key = optional(object({
      key_name              = string
      key_vault_resource_id = string

      key_version = optional(string, null) # Not supported in CosmosDB

      user_assigned_identity = optional(object({
        resource_id = string
      }), null)
    }), null)
    geo_locations = optional(set(object({
      location          = string
      failover_priority = number
      zone_redundant    = optional(bool, true)
    })), null)
    local_authentication_disabled      = optional(bool, false)
    analytical_storage_enabled         = optional(bool, false)
    access_key_metadata_writes_enabled = optional(bool, false)
    automatic_failover_enabled         = optional(bool, true)
    free_tier_enabled                  = optional(bool, false)
    multiple_write_locations_enabled   = optional(bool, false)
    partition_merge_enabled            = optional(bool, false)
    consistency_policy = optional(object({
      max_interval_in_seconds = optional(number, 5)
      max_staleness_prefix    = optional(number, 100)
      consistency_level       = optional(string, "ConsistentPrefix")
    }), {})
    backup = optional(object({
      retention_in_hours  = optional(number, 8)
      interval_in_minutes = optional(number, 240)
      storage_redundancy  = optional(string, "Geo")
      type                = optional(string, "Continuous")
      tier                = optional(string, "Continuous30Days")
    }), {})
    capacity = optional(object({
      total_throughput_limit = optional(number, -1)
    }), {})
    analytical_storage_config = optional(object({
      schema_type = string
    }), null)
    cors_rule = optional(object({
      allowed_headers    = set(string)
      allowed_methods    = set(string)
      allowed_origins    = set(string)
      exposed_headers    = set(string)
      max_age_in_seconds = optional(number, null)
    }), null)
    capabilities = optional(set(object({
      name = string
    })), [])
    minimal_tls_version                   = optional(string, "Tls12")
    public_network_access_enabled         = optional(bool, true)
    network_acl_bypass_for_azure_services = optional(bool, false)
    network_acl_bypass_ids                = optional(set(string), [])
    ip_range_filter                       = optional(set(string), [])
    virtual_network_rules = optional(set(object({
      subnet_id = string
    })), [])
    sql_dedicated_gateway = optional(object({
      instance_size  = string
      instance_count = optional(number, 1)
    }), null)
    sql_databases = optional(map(object({
      name       = string
      throughput = optional(number, null)

      autoscale_settings = optional(object({
        max_throughput = number
      }), null)

      containers = optional(map(object({
        partition_key_path = string
        name               = string

        throughput             = optional(number, null)
        default_ttl            = optional(number, null)
        analytical_storage_ttl = optional(number, null)

        unique_keys = optional(list(object({
          paths = set(string)
        })), [])

        autoscale_settings = optional(object({
          max_throughput = number
        }), null)

        functions = optional(map(object({
          body = string
          name = string
        })), {})

        stored_procedures = optional(map(object({
          body = string
          name = string
        })), {})

        triggers = optional(map(object({
          body      = string
          type      = string
          operation = string
          name      = string
        })), {})

        conflict_resolution_policy = optional(object({
          mode                          = string
          conflict_resolution_path      = optional(string, null)
          conflict_resolution_procedure = optional(string, null)
        }), null)

        indexing_policy = optional(object({
          indexing_mode = string

          included_paths = optional(set(object({
            path = string
          })), [])

          excluded_paths = optional(set(object({
            path = string
          })), [])

          composite_indexes = optional(set(object({
            indexes = set(object({
              path  = string
              order = string
            }))
          })), [])

          spatial_indexes = optional(set(object({
            path = string
          })), [])
        }), null)

      })), {})
    })), {})
  }))

}

variable "cosmosdb_pgsql" {
  description = "Manages an Azure Cosmos DB for PostgreSQL Cluster"
  type = map(object({
    name                                 = string
    resource_group_name                  = string
    location                             = string
    node_count                           = number
    citus_version                        = optional(string, null)
    coordinator_public_ip_access_enabled = optional(bool, true)
    coordinator_server_edition           = optional(string, "GeneralPurpose")
    coordinator_storage_quota_in_mb      = optional(number, null)
    coordinator_vcore_count              = optional(number, null)
    ha_enabled                           = optional(bool, false)
    node_public_ip_access_enabled        = optional(bool, false)
    node_server_edition                  = optional(string, "MemoryOptimized")
    node_storage_quota_in_mb             = optional(number, null)
    node_vcores                          = optional(number, null)
    point_in_time_in_utc                 = optional(string, null)
    preferred_primary_zone               = optional(string, null)
    shards_on_coordinator_enabled        = optional(bool, false)
    source_location                      = optional(string, null)
    source_resource_id                   = optional(string, null)
    sql_version                          = optional(number, null)
    tags                                 = optional(map(string), {})
    maintenance_window = optional(object({
      day_of_week  = optional(number, 0)
      start_hour   = optional(string, "0")
      start_minute = optional(string, "0")
    }), {})
    timeouts = optional(object({
      create = optional(string, "3h")
      delete = optional(string, "5m")
      read   = optional(string, "3h")
      update = optional(string, "3h")
    }), {})
  }))

}

variable "db_type" {
  description = "The type of database to create (SQL, MongoDB, Cassandra, PostgreSQL)"
  type        = string
  default     = null
}

variable "appid" {
  description = "The related application for resources. Used for tagging and naming purposes."
  type        = string
}

variable "appname" {
  description = "the app name for the resources.  Used for tagging and naming purposes"
  type        = string
}

variable "env" {
  description = "The environment code the for resources. Used for tagging and naming purposes."
  type        = string
}

variable "costCostCenter" {
  description = "The cost center code for resources. Used for tagging and naming purposes."
  type        = string
}

variable "costVP" {
  description = "The cost vp for resources. Used for tagging purposes."
  type        = string
}

variable "costAppOwnerTech" {
  description = "The app owner responsible for resources. Used for tagging and naming purposes."
  type        = string
}

variable "costAppOwnerManager" {
  description = "The app owner manager responsible for resources. Used for tagging purposes."
  type        = string
}

variable "costBudgetOwner" {
  description = "The budget owner responsible for resources. Used for tagging purposes."
  type        = string
}

variable "costbaseline" {
  description = "year resource created"
  type        = string
}

variable "resourcetype" {
  description = "resource type -- 3 letters"
  type        = string
}

variable "costDivision" {
  description = "cost division"
  type        = string
}

variable "costAllocation" {
  description = "can only be sharedcosts or chargeback"
  type        = string
}

variable "appFunction" {
  description = "app function"
  type        = string
}

variable "monthlyBudget" {
  description = "monthly budget"
  type        = string
}

variable "additionalcontext" {
  description = "used for naming purposes such as 01 or 02"
  type        = string
}

variable "location" {
  description = "the location where the resource need to be deployed"
  type        = string
}

variable "managed_by" {
  description = "resource group is managed by"
  type        = string
  default     = null
}
