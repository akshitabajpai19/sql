# #############################################################################
# # OUTPUTS Azure SQL Server
# #############################################################################

output "azuresql_server_ids" {
  description = "IDs of the Azure SQL servers"
  value       = { for k, v in azurerm_mssql_server.this : k => v.id }
}

output "azuresql_server_names" {
  description = "Names of the Azure SQL servers"
  value       = { for k, v in azurerm_mssql_server.this : k => v.name }
}

output "azuresql_fqdns" {
  description = "Fully Qualified Domain Names of the Azure SQL servers"
  value       = { for k, v in azurerm_mssql_server.this : k => v.fully_qualified_domain_name }
}

output "azuresql_versions" {
  description = "Versions of the Azure SQL servers"
  value       = { for k, v in azurerm_mssql_server.this : k => v.version }
}

