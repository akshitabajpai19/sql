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

variable "posgresql_server_name" {
  type = string
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Enable public network access."
}

variable "timeouts" {
  type = object({
    create = optional(string, "1h")
    update = optional(string, "1h")
    read   = optional(string, "5m")
    delete = optional(string, "1h")
  })
  description = "Map that holds the timeout configuration"
  default = {
    create = "1h"
    update = "1h"
    read   = "5m"
    delete = "1h"
  }
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
  default     = 31
  type        = number
  description = "Number of days to retain backups."
}

variable "posgresql_zone" {
  type    = string
  default = "1"
}

variable "key_vault_name" {
  type    = string
  default = null
}

variable "key_vault_rg_name" {
  type    = string
  default = null
}

variable "customer_managed_key" {
  description = "Map of customer managed key configurations"
  type = map(object({
    key_vault_key_id                     = string
    primary_user_assigned_identity_id    = optional(string, null)
    geo_backup_key_vault_key_id          = optional(string, null)
    geo_backup_user_assigned_identity_id = optional(string, null)
  }))
  default = {}
}

variable "maintenance_window" {
  description = "Map of maintenance window configuration"
  type = map(object({
    day_of_week  = string
    start_hour   = string
    start_minute = string
  }))
  default = {}
}


variable "posgresql_storage_tier" {
  type        = string
  default     = null
  description = "The storage tier for the server."
}

variable "resource_group_name" {
  type    = string
  default = null
}

variable "user_assigned_identity_ids" {
  description = "User Identities"
  type = map(object({
    identity_id = string
  }))
  default = {}
}

variable "ad_auth_enabled" {
  description = "to enable ad authorization"
  default     = false
  type        = bool
}

variable "password_auth_enabled" {
  description = "Enable password authentication."
  type        = bool
  default     = true
}

variable "high_availability" {
  description = "Map of high availability configurations"
  type = map(object({
    high_availability_mode    = string
    standby_availability_zone = optional(string, null)
  }))
  default = {}
}

variable "posgresql_create_mode" {
  default     = null
  type        = string
  description = "The mode to create the PostgreSQL server."
}

variable "posgresql_source_server_id" {
  default     = null
  type        = string
  description = "The source server ID for replication."
}

variable "point_in_time_restore_time_in_utc" {
  default     = null
  type        = string
  description = "Point in time to restore the server."
}

variable "auto_grow_enabled" {
  default     = false
  type        = bool
  description = "Enable auto-grow for storage."
}

variable "replication_role" {
  default     = null
  type        = string
  description = "The replication role for the server."
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

variable "subscription_id" {
  description = "The subscription ID to use."
  type        = string
  default     = null
}

variable "location" {
  description = "The Azure region where resources will be deployed"
  type        = string
  default     = ""
}

variable "resourcetype" {
  description = "the resource type being deployed see naming standards for example"
  type        = string
  default     = ""
}

variable "appid" {
  description = "The related application for resources. Used for tagging and naming purposes."
  type        = string
  default     = ""
}

variable "appname" {
  description = "the app name for the resources.  Used for tagging and naming purposes"
  type        = string
  default     = ""
}

variable "env" {
  description = "The environment code the for resources. Used for tagging and naming purposes."
  type        = string
  default     = ""
}

variable "costCostCenter" {
  description = "The cost center code for resources. Used for tagging and naming purposes."
  type        = string
  default     = ""
}

variable "costVP" {
  description = "The cost vp for resources. Used for tagging purposes."
  type        = string
  default     = ""
}

variable "costAppOwnerTech" {
  description = "The app owner responsible for resources. Used for tagging and naming purposes."
  type        = string
  default     = ""
}

variable "costAppOwnerManager" {
  description = "The app owner manager responsible for resources. Used for tagging purposes."
  type        = string
  default     = ""
}

variable "costBudgetOwner" {
  description = "The budget owner responsible for resources. Used for tagging purposes."
  type        = string
  default     = ""
}

variable "costDivision" {
  description = "cost division"
  type        = string
  default     = ""
}

variable "costAllocation" {
  description = "can only be sharedcosts or chargeback"
  type        = string
  default     = ""
}

variable "appFunction" {
  description = "app function"
  type        = string
  default     = ""
}

variable "monthlyBudget" {
  description = "monthly budget"
  type        = string
  default     = ""
}

variable "costbaseline" {
  description = "year resource created"
  type        = string
  default     = ""
}

variable "charset" {
  description = "Specifies the Charset for the Azure PostgreSQL Flexible Server Database"
  type = string
  default = "UTF8"
}

variable "collation" {
  description = "Specifies the Collation for the Azure PostgreSQL Flexible Server Database"
  type = string
  default = "en_US.utf8"  
}