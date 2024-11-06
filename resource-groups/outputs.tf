output "name" {
  description = "The name of the resource group"
  value       = module.avm-res-resources-resourcegroup.name
}

output "resource" {
  description = "This is the full output for the resource group."
  value       = module.avm-res-resources-resourcegroup
}

output "resource_id" {
  description = "The resource Id of the resource group"
  value       = module.avm-res-resources-resourcegroup.resource_id
}
