output "azuresql_databases_ids" {
  value       = [for x in azurerm_mssql_database.this : x.id]
  description = "The list of all Azure SQL database resource ids"
}
output "azuresql_databases_names" {
  value       = [for x in azurerm_mssql_database.this : x.name]
  description = "List of all Azure SQL database resource names"
}