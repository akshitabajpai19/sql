scaling_plan = {
  "scaling_plan1" = {
    virtual_desktop_scaling_plan_location            = "Central US"
    virtual_desktop_scaling_plan_name                = "test-new"
    virtual_desktop_scaling_plan_resource_group_name = "sql-rg"
    virtual_desktop_scaling_plan_schedule = [{
      days_of_week                         = ["Monday", "Tuesday", "Wednesday"]
      name                                 = "Weekday Schedule"
      off_peak_load_balancing_algorithm    = "BreadthFirst"
      off_peak_start_time                  = "22:00"
      peak_load_balancing_algorithm        = "DepthFirst"
      peak_start_time                      = "08:00"
      ramp_down_capacity_threshold_percent = 20
      ramp_down_force_logoff_users         = true
      ramp_down_load_balancing_algorithm   = "BreadthFirst"
      ramp_down_minimum_hosts_percent      = 10
      ramp_down_notification_message       = "System will log off users in 10 minutes."
      ramp_down_start_time                 = "18:00"
      ramp_down_stop_hosts_when            = "ZeroSessions"
      ramp_down_wait_time_minutes          = 15
      ramp_up_capacity_threshold_percent   = 80
      ramp_up_load_balancing_algorithm     = "DepthFirst"
      ramp_up_minimum_hosts_percent        = 50
      ramp_up_start_time                   = "06:00"
      },
      {
        name                                 = "Weekend"
        days_of_week                         = ["Saturday", "Sunday"]
        ramp_up_start_time                   = "09:00"
        ramp_up_load_balancing_algorithm     = "BreadthFirst"
        ramp_up_minimum_hosts_percent        = 50
        ramp_up_capacity_threshold_percent   = 80
        peak_start_time                      = "10:00"
        peak_load_balancing_algorithm        = "DepthFirst"
        ramp_down_start_time                 = "17:00"
        ramp_down_load_balancing_algorithm   = "BreadthFirst"
        ramp_down_minimum_hosts_percent      = 50
        ramp_down_force_logoff_users         = true
        ramp_down_wait_time_minutes          = 15
        ramp_down_notification_message       = "The session will end in 15 minutes."
        ramp_down_capacity_threshold_percent = 50
        ramp_down_stop_hosts_when            = "ZeroActiveSessions"
        off_peak_start_time                  = "18:00"
        off_peak_load_balancing_algorithm    = "BreadthFirst"
    }]
    virtual_desktop_scaling_plan_time_zone     = "Eastern Standard Time"
    enable_telemetry                           = true
    virtual_desktop_scaling_plan_description   = "new hostpool"
    virtual_desktop_scaling_plan_friendly_name = "just new tag"
    virtual_desktop_scaling_plan_host_pool = [{
      hostpool_id          = "/subscriptions/XXXXXXXXXXXXXX/resourceGroups/sql-rg/providers/Microsoft.DesktopVirtualization/hostPools/new-host-pool"
      scaling_plan_enabled = true
    }]
  }
}
