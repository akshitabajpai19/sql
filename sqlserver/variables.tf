variable "sql_servers" {
  type = map(object({
    name                                         = string
    resource_group_name                          = string
    location                                     = string
    version                                      = string
    administrator_login_name                     = optional(string, null)
    connection_policy                            = optional(string, null)
    transparent_data_encryption_key_vault_key_id = optional(string, null)
    public_network_access_enabled                = optional(bool, null)
    minimum_tls_version                          = optional(string, null)
    outbound_network_restriction_enabled         = optional(bool, null)
    primary_user_assigned_identity_id            = optional(string, null)
    tags                                         = map(string)
  }))
}
variable "identity" {
  description = "A map of identity objects"
  type = map(object({
    type         = string
    identity_ids = list(string)
  }))
  default = {}
}

variable "azuread_administrator" {
  description = "A map of Azure AD administrator objects"
  type = map(object({
    login_username              = string
    object_id                   = string
    tenant_id                   = string
    azuread_authentication_only = bool
  }))
  default = {}
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
