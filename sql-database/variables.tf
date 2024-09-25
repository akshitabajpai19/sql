variable "database_names" {
  description = "List of Azure SQL database names"
  type = map(object({

    server_resource_group_name                                 = string
    name                                                       = string
    sql_server_name                                            = string
    collation                                                  = string
    max_size_gb                                                = number
    sku_name                                                   = string
    zone_redundant                                             = string
    elastic_pool_id                                            = string
    create_mode                                                = string
    creation_source_database_id                                = string
    restore_point_in_time                                      = string
    auto_pause_delay_in_minutes                                = number
    enclave_type                                               = string
    geo_backup_enabled                                         = bool
    maintenance_configuration_name                             = string
    ledger_enabled                                             = bool
    license_type                                               = string
    min_capacity                                               = string
    recover_database_id                                        = string
    recovery_point_id                                          = string
    restore_dropped_database_id                                = string
    restore_long_term_retention_backup_id                      = string
    read_replica_count                                         = number
    read_scale                                                 = string
    sample_name                                                = string
    storage_account_type                                       = string
    transparent_data_encryption_enabled                        = bool
    transparent_data_encryption_key_vault_key_id               = string
    transparent_data_encryption_key_automatic_rotation_enabled = bool
    secondary_type                                             = string
    tags                                                       = optional(map(string), null)

  }))

}


#Naming and Tags 
variable "location" {
  description = "The Azure region where resources will be deployed"
  type        = string
}

variable "resourcetype" {
  description = "the resource type being deployed see naming standards for example"
  type        = string
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

variable "costbaseline" {
  description = "year resource created"
  type        = string
}


