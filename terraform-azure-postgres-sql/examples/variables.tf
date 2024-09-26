variable "virtual_network_name" {
  description = "name of the VNet"
  type        = string
}

variable "postgres_admin" {
  description = "PostgreSQL default admin."
  type        = string
  default     = null
}

variable "geo_redundant_backup_enabled" {
  description = "Is Geo-Redundant backup enabled on the PostgreSQL Flexible Server."
  type        = bool
  default     = false
}
variable "user_assigned_identity_ids" {
  description = "User Identities"
  type = map(object({
    identity_id = string
  }))
  default = {}
}

variable "high_availability" {
  description = "Map of high availability configurations"
  type = map(object({
    high_availability_mode = string
  }))
  default = {}
}

variable "posgresql_server_name" {
  type = string
}

variable "posgresql_sku_name" {
  description = "(Optional) The SKU Name for the PostgreSQL Flexible Server. The name of the SKU, follows the tier + name pattern (e.g. B_Standard_B1ms, GP_Standard_D2s_v3, MO_Standard_E4s_v3)."
  type        = string
  default     = null
}

variable "posgresql_version" {
  description = " (Optional) The version of PostgreSQL Flexible Server to use. Possible values are 11,12, 13, 14, 15 and 16. Required when create_mode is Default."
  type        = number
  default     = 14
}

variable "posgresql_storage_mb" {
  description = "Specifies the version of PostgreSQL to use."
  type        = number
  default     = 262144
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(any)
  default     = {}
}

variable "delegated_subnet_id" {
  description = "The subnet where you want the database created. The subnet must be delegated to Microsoft.DBforPostgreSQL/flexibleServers."
  type        = string
  default     = null
}

variable "private_dns_zone_id" {
  description = "The ID of the private DNS zone to create the PostgreSQL Flexible Server. The private DNS zone must end with the suffix .postgres.database.azure.com."
  type        = string
  default     = null
}

variable "backup_retention_days" {
  default = 31
  type    = number
}

variable "posgresql_zone" {
  type    = string
  default = "1"
}

variable "key_vault_key_name" {
  type    = string
  default = null
}

variable "enable_encryption" {
  type    = bool
  default = null
}

variable "customer_managed_key" {
  description = "Map of customer managed key configurations"
  type = map(object({
    key_vault_key_id                  = string
    primary_user_assigned_identity_id = string
  }))
  default = {}
}


variable "key_vault_name" {
  type    = string
  default = null
}

variable "key_vault_rg_name" {
  type    = string
  default = null
}

variable "resource_group_name" {
  type    = string
  default = null
}

variable "user_assigned_identity_name" {
  type    = string
  default = null
}


variable "posgresql_create_mode" {
  default = null
  type    = string
}

variable "posgresql_source_server_id" {
  default = null
  type    = string
}

variable "logs_destinations_ids" {
  type        = list(string)
  description = "List of destination resources IDs for logs diagnostic destination."
  default     = []
}

variable "diagnostics_settings_name" {
  type    = string
  default = ""
}

variable "enable_diagnostics" {
  type    = bool
  default = true
}

variable "ad_auth_enabled" {
  default = false
  type    = bool
}

variable "public_network_access_enabled" {
  default = true
  type    = bool
}

variable "point_in_time_restore_time_in_utc" {
  default = null
  type    = string
}

variable "auto_grow_enabled" {
  default = false
  type    = bool
}

variable "replication_role" {
  default = null
  type    = string
}


variable "postgresql_configurations" {
  description = "PostgreSQL configurations to enable."
  type        = map(string)
  default     = {}
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

variable "postgres_db" {
  description = "Name of the PostgreSQL database"
  type        = string

}

variable "ag_resource_group_name" {
  description = "Name of the resource group for the action group"
  type        = string
  default     = null
}

variable "alert_definition" {
  description = "If you wish to override the default alerts, define them here.  Set to {} if you wish to disable alerting"
  type = map(object({
    name_prefix              = string
    description              = string
    enabled                  = optional(bool)
    auto_mitigate            = optional(bool)
    frequency                = optional(string)
    window_size              = optional(string)
    severity                 = optional(number)
    target_resource_type     = optional(string)
    target_resource_location = optional(string)

    criteria = map(object({
      metric_namespace = string
      metric_name      = string
      aggregation      = string
      operator         = string
      threshold        = string

      dimension = optional(map(object({
        name     = string
        operator = string
        values   = list(string)
      })))
    }))
  }))
  default = {
    "CPU Percent" = {
      name_prefix   = "CPU Percent"
      description   = "Alert when the CPU percent is greater than 90%"
      enabled       = true
      auto_mitigate = true
      severity      = 1
      criteria = {
        "default" = {
          metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
          metric_name      = "cpu_percent"
          aggregation      = "Average"
          operator         = "GreaterThan"
          threshold        = "90"
        }
      }
    }
    "Is DB Alive" = {
      name_prefix   = "Is DB Alive"
      description   = "Alert if the DB is down for whatever reason"
      enabled       = true
      auto_mitigate = true
      severity      = 1
      criteria = {
        "default" = {
          metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
          metric_name      = "is_db_alive"
          aggregation      = "Maximum"
          operator         = "LessThan"
          threshold        = "1"
        }
      }
    }
    "Memory Percent" = {
      name_prefix   = "Memory Percent"
      description   = "Alert if the memory on the DB is greater than 90%"
      enabled       = true
      auto_mitigate = true
      severity      = 2
      criteria = {
        "default" = {
          metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
          metric_name      = "memory_percent"
          aggregation      = "Average"
          operator         = "GreaterThan"
          threshold        = "90"
        }
      }
    }
    "Storage Percent" = {
      name_prefix   = "Storage Percent"
      description   = "Alert if the storage on the DB is greater than 90%"
      enabled       = true
      auto_mitigate = true
      severity      = 2
      criteria = {
        "default" = {
          metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
          metric_name      = "storage_percent"
          aggregation      = "Average"
          operator         = "GreaterThan"
          threshold        = "90"
        }
      }
    }
    "Disk iops consumed percentage" = {
      name_prefix   = "Disk iops consumed percentage"
      description   = "Alert if the disk iops concumed on the DB is greater than 90%"
      enabled       = true
      auto_mitigate = true
      severity      = 2
      criteria = {
        "default" = {
          metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
          metric_name      = "disk_iops_consumed_percentage"
          aggregation      = "Average"
          operator         = "GreaterThan"
          threshold        = "90"
        }
      }
    }
    "IO Operations per second" = {
      name_prefix   = "IO Operations per second"
      description   = "Alert if the IO operations per second on the DB is greater than 450"
      enabled       = true
      auto_mitigate = true
      severity      = 2
      criteria = {
        "default" = {
          metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
          metric_name      = "iops"
          aggregation      = "Average"
          operator         = "GreaterThan"
          threshold        = "450"
        }
      }
    }
    "Deadlocks" = {
      name_prefix   = "IO Operations per second"
      description   = "Alert if the number of deadlocks detected on the DB is greater than 1"
      enabled       = true
      auto_mitigate = true
      severity      = 3
      criteria = {
        "default" = {
          metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
          metric_name      = "deadlocks"
          aggregation      = "Total"
          operator         = "GreaterThan"
          threshold        = "1"
        }
      }
    }
    "Failed Connections" = {
      name_prefix   = "Failed Connections"
      description   = "Alert if the number of failed connections on the DB is greater than 5"
      enabled       = true
      auto_mitigate = true
      severity      = 3
      criteria = {
        "default" = {
          metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
          metric_name      = "connections_failed"
          aggregation      = "Total"
          operator         = "GreaterThan"
          threshold        = "5"
        }
      }
    }
    "Active Connections" = {
      name_prefix   = "Active Connections"
      description   = "Alert if the number of active connections on the DB is greater than 120"
      enabled       = true
      auto_mitigate = true
      severity      = 3
      criteria = {
        "default" = {
          metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
          metric_name      = "active_connections"
          aggregation      = "Average"
          operator         = "GreaterThan"
          threshold        = "120"
        }
      }
    }
  }
}
