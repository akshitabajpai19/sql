variable "scaling_plan" {
  type = map(object({
    virtual_desktop_scaling_plan_location            = string
    virtual_desktop_scaling_plan_name                = string
    virtual_desktop_scaling_plan_resource_group_name = string
    virtual_desktop_scaling_plan_schedule = list(object({
      days_of_week                         = set(string)
      name                                 = string
      off_peak_load_balancing_algorithm    = string
      off_peak_start_time                  = string
      peak_load_balancing_algorithm        = string
      peak_start_time                      = string
      ramp_down_capacity_threshold_percent = number
      ramp_down_force_logoff_users         = bool
      ramp_down_load_balancing_algorithm   = string
      ramp_down_minimum_hosts_percent      = number
      ramp_down_notification_message       = string
      ramp_down_start_time                 = string
      ramp_down_stop_hosts_when            = string
      ramp_down_wait_time_minutes          = number
      ramp_up_capacity_threshold_percent   = optional(number)
      ramp_up_load_balancing_algorithm     = string
      ramp_up_minimum_hosts_percent        = optional(number)
      ramp_up_start_time                   = string
    }))
    virtual_desktop_scaling_plan_time_zone = string
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
    enable_telemetry = optional(bool, true)
    lock = optional(object({
      kind = string
      name = optional(string, null)
    }), null)
    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
      principal_type                         = optional(string, null)
    })), {})
    virtual_desktop_scaling_plan_description   = optional(string, null)
    virtual_desktop_scaling_plan_exclusion_tag = optional(string, null)
    virtual_desktop_scaling_plan_friendly_name = optional(string, null)
    virtual_desktop_scaling_plan_host_pool = optional(list(object({
      hostpool_id          = string
      scaling_plan_enabled = bool
    })), null)
    virtual_desktop_scaling_plan_tags = optional(map(string), null)
    virtual_desktop_scaling_plan_timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }), null)
  }))
}


