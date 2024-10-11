output "private_endpoints" {
  description = "A map of private endpoints. The map key is the supplied input to var.private_endpoints. The map value is the entire azurerm_private_endpoint resource."
  value       = module.avm-res-sql-server.private_endpoints
}

output "resource" {
  description = "This is the full output for the resource."
  value       = module.avm-res-sql-server.resource
}

output "resource_databases" {
  description = "A map of databases. The map key is the supplied input to var.databases. The map value is the entire azurerm_mssql_database resource."
  value       = module.avm-res-sql-server.resource_databases
}

output "resource_elasticpools" {
  description = "A map of elastic pools. The map key is the supplied input to var.elastic_pools. The map value is the entire azurerm_mssql_elasticpool resource."
  value       = module.avm-res-sql-server.resource_elasticpools
}

output "resource_id" {
  description = "This is the id of the resource."
  value       = module.avm-res-sql-server.resource_id
}

output "resource_name" {
  description = "This is the name of the resource."
  value       = module.avm-res-sql-server.resource_name
}
