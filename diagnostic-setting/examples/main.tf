locals {
  naming = "${var.resourcetype}${var.appname}${var.env}${var.location}"
}

data "azurerm_virtual_network" "example" {
  name                = "testvnet50"
  resource_group_name = "test-rg15"
}

module "diagnostics_setting_setup" {
  source                         = "../"
  for_each                       = var.enable_diagnostic_setting == true ? { this = var.enable_diagnostic_setting } : {}
  resource_id                    = data.azurerm_virtual_network.example.id
  diagnostics_settings_name      = var.diagnostics_settings_name != null ? var.diagnostics_settings_name : "rv${local.naming}${var.additionalcontext}"
  log_categories                 = var.log_categories
  log_category_groups            = var.log_category_groups
  excluded_log_categories        = var.excluded_log_categories
  excluded_log_category_groups   = var.excluded_log_category_groups
  metric_categories              = var.metric_categories
  logs_destinations_ids          = var.logs_destinations_ids
  log_analytics_destination_type = var.log_analytics_destination_type
  depends_on                     = [data.azurerm_virtual_network.example]
}