output "name" {
  description = "The resource ID for the resource."
  value       = module.avm-res-dbforpostgresql-flexibleserver.name
}

output "private_endpoints" {
  description = <<DESCRIPTION
  A map of the private endpoints created.
  DESCRIPTION
  value       = module.avm-res-dbforpostgresql-flexibleserver.private_endpoints
}

output "resource" {
  description = "This is the full output for the resource."
  value       = module.avm-res-dbforpostgresql-flexibleserver.resource
}

output "resource_id" {
  description = "The resource ID for the resource."
  value       = module.avm-res-dbforpostgresql-flexibleserver.resource_id
}
