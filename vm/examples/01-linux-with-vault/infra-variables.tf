variable "infra_rg_vnet_name" {
  type        = string
  description = "name of the resource group for the vnet"
}
variable "infra_rg_app_name" {
  type        = string
  description = "name of the resource group for the application"
}
variable "infra_vnet_name" {
  type        = string
  description = "name of the vnet"
}

variable "infra_subnet_pe_name" {
  type        = string
  description = "name subnet used for private endpoints"
}

variable "private_dns_rg" {
  description = "private dns zone resource group"
  default     = "rg-dns_infrastructure"
}

variable "billing_account_name" {
  description = "The name of the billing account."
  default     = "78358115"
  type        = string
}

variable "enrollment_account_name" {
  description = "The name of the enrollment account."
  default     = "222349"
  type        = string
}

variable "mgmt_sub_id" {
  description = "the mgmt subcription id for where the private dns zones reside"
  default     = "000bdcc8-114c-418a-ad9d-a1ac486ac658"
}

variable "tenant_id" {
  description = "tenant id where the subscription to deploy the aks cluster is"
  default     = "72b17115-9915-42c0-9f1b-4f98e5a4bcd2"
}

############################################################
## Naming and Tags ##
############################################################
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

variable "additionalcontext" {
  description = "used for naming purposes such as 01 or 02"
  type        = string
  default     = "01"
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

#subscription
variable "subscription_id" {
  description = "The id of the subscription."
  type        = string
}

variable "management_group_name" {
  description = "The name of the management group to associate to the subscription."
  type        = string
}

variable "application_name" {
  description = "Short name of the application."
}

variable "costbaseline" {
  description = "year resource created"
  type        = string
}
