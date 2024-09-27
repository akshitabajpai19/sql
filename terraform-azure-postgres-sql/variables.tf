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

variable "postgre_sql_timeouts" {
  type = object({
    create = string 
    update = string 
    read   = string 
    delete = string 
  })
  description = "Map that holds the Service Bus configuration"
  default     = null
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
    key_vault_key_id                  = string
    primary_user_assigned_identity_id = string
  }))
  default = {}
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

variable "high_availability" {
  description = "Map of high availability configurations"
  type = map(object({
    high_availability_mode = string
  }))
  default = {}
}

variable "posgresql_create_mode" {
  default = null
  type    = string
}

variable "posgresql_source_server_id" {
  default = null
  type    = string
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
