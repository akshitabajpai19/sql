variable "nsg_diagnostic_settings" {
  type = map(object({
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
  }))
  default     = {}
}

variable "public_ip_sku" {
  description = "SKU to be used with this public IP - Basic or Standard"
  type        = string
  default     = "Standard"

  validation {
    condition     = (contains(["basic", "standard"], lower(var.public_ip_sku)))
    error_message = "Public IP sku can only be \"Basic\" or \"Standard\"."
  }
}

