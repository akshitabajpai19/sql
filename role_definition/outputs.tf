# #############################################################################
# # OUTPUTS Role Definitions
# #############################################################################

output "role_definition_ids_map" {
  value       = { for rd in azurerm_role_definition.this : rd.name => rd.id }
  description = "The Map of the Role Definition IDs."
}

