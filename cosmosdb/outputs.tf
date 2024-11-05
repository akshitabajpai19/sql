output "cosmosdb_keys" {
  description = "The keys for the CosmosDB Account from the module."
  sensitive   = true
  value       = { for k, v in module.avm-res-documentdb-databaseaccount : k => v.cosmosdb_keys }
}

output "cosmosdb_mongodb_connection_strings" {
  description = "The MongoDB connection strings for the CosmosDB Account."
  sensitive   = true
  value       = { for k, v in module.avm-res-documentdb-databaseaccount : k => v.cosmosdb_mongodb_connection_strings }
}

output "cosmosdb_sql_connection_strings" {
  description = "The SQL connection strings for the CosmosDB Account."
  sensitive   = true
  value       = { for k, v in module.avm-res-documentdb-databaseaccount : k => v.cosmosdb_sql_connection_strings }
}

output "mongo_databases" {
  description = "A map of the MongoDB databases created, with the database name as the key and the database id and collections as the value."
  value       = { for k, v in module.avm-res-documentdb-databaseaccount : k => v.mongo_databases }
}

output "name" {
  description = "The name of the cosmos db account created."
  value       = { for k, v in module.avm-res-documentdb-databaseaccount : k => v.name }
}

output "resource_diagnostic_settings" {
  description = "A map of the diagnostic settings created, with the diagnostic setting name as the key and the diagnostic setting ID as the value."
  value       = { for k, v in module.avm-res-documentdb-databaseaccount : k => v.resource_diagnostic_settings }
}

output "resource_id" {
  description = "The resource ID of the cosmos db account created."
  value       = { for k, v in module.avm-res-documentdb-databaseaccount : k => v.resource_id }
}

output "resource_locks" {
  description = "A map of the management locks created, with the lock name as the key and the lock ID as the value."
  value       = { for k, v in module.avm-res-documentdb-databaseaccount : k => v.resource_locks }
}

output "resource_private_endpoints" {
  description = "A map of the management locks created, with the lock name as the key and the lock ID as the value."
  value       = { for k, v in module.avm-res-documentdb-databaseaccount : k => v.resource_private_endpoints }
}

output "resource_private_endpoints_application_security_group_association" {
  description = "The IDs of the private endpoint application security group associations created."
  value       = { for k, v in module.avm-res-documentdb-databaseaccount : k => v.resource_private_endpoints_application_security_group_association }
}

output "resource_role_assignments" {
  description = "A map of the role assignments created, with the assignment key as the map key and the assignment value as the map value."
  value       = { for k, v in module.avm-res-documentdb-databaseaccount : k => v.resource_role_assignments }
}

output "sql_databases" {
  description = "A map of the SQL databases created, with the database name as the key and the database ID, containers, functions, stored_procedures and triggers as the value."
  value       = { for k, v in module.avm-res-documentdb-databaseaccount : k => v.sql_databases }
}

output "sql_dedicated_gateway" {
  description = "The IDs of the SQL dedicated gateways created."
  value       = { for k, v in module.avm-res-documentdb-databaseaccount : k => v.sql_dedicated_gateway }
}

output "cosmos_pgsql_id" {
  description = "The IDs of the PostgreSQL clusters created."
  value       = { for k, v in azurerm_cosmosdb_postgresql_cluster.cosmosdb_pgsql : k => v.id }
}

output "pgsql_servers" {
  description = "The FQDN and name of the servers."
  value = {
    for k, v in azurerm_cosmosdb_postgresql_cluster.cosmosdb_pgsql : k => v.servers
  }
}