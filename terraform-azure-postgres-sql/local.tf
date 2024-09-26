# locals {
#   alert_definition = { for alert_name, alert in var.alert_definition : alert_name => merge(
#     alert, 
#     {
#         "actions_group_ids" = [data.azurerm_monitor_action_group.action_groups.id],
#         "scopes" = [azurerm_postgresql_flexible_server.posgresflexible.id],
#         "resource_group_name" = var.resource_group_name,
#         "name" = "${alert.name_prefix} - ${var.posgresql_server_name}"
#     }
#   )}

#   ag_resource_group_name = var.ag_resource_group_name != null ? var.ag_resource_group_name : var.resource_group_name
# }