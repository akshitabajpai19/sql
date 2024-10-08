# This is the module call
module "avm-res-desktopvirtualization-scalingplan" {
  source   = "Azure/avm-res-desktopvirtualization-scalingplan/azurerm"
  version  = "0.1.3"
  for_each = var.scaling_plan

  #Required variables
  virtual_desktop_scaling_plan_location            = each.value.virtual_desktop_scaling_plan_location
  virtual_desktop_scaling_plan_resource_group_name = each.value.virtual_desktop_scaling_plan_resource_group_name
  virtual_desktop_scaling_plan_time_zone           = each.value.virtual_desktop_scaling_plan_time_zone
  virtual_desktop_scaling_plan_name                = each.value.virtual_desktop_scaling_plan_name
  virtual_desktop_scaling_plan_schedule            = each.value.virtual_desktop_scaling_plan_schedule

  #optional variables
  diagnostic_settings                        = try(each.value.diagnostic_settings, null) != null ? each.value.diagnostic_settings : {}
  enable_telemetry                           = try(each.value.enable_telemetry, null) != null ? each.value.enable_telemetry : false
  lock                                       = try(each.value.lock, null)
  role_assignments                           = try(each.value.role_assignments, null) != null ? each.value.role_assignments : {}
  virtual_desktop_scaling_plan_description   = try(each.value.virtual_desktop_scaling_plan_description, null)
  virtual_desktop_scaling_plan_exclusion_tag = try(each.value.virtual_desktop_scaling_plan_exclusion_tag, null)
  virtual_desktop_scaling_plan_friendly_name = try(each.value.virtual_desktop_scaling_plan_friendly_name, null)
  virtual_desktop_scaling_plan_host_pool     = try(each.value.virtual_desktop_scaling_plan_host_pool, null) != null ? each.value.virtual_desktop_scaling_plan_host_pool : []
  virtual_desktop_scaling_plan_tags          = try(each.value.virtual_desktop_scaling_plan_tags, null)
  virtual_desktop_scaling_plan_timeouts      = try(each.value.virtual_desktop_scaling_plan_timeouts, null)
}
