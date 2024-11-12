output "resource_id" {
  description = "The id of the newly created vNet"
  value       = {for k, v in module.avm-res-network-virtualnetwork : k => v.resource_id}
}

output "name" {
  description = "The name of the newly created vNet"
  value       = {for k, v in module.avm-res-network-virtualnetwork : k => v.name}
}

output "resource" {
  description = "The resource object of the newly created vNet"
  value       = {for k, v in module.avm-res-network-virtualnetwork : k => v.resource}
}

output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = {for k, v in module.avm-res-network-virtualnetwork : k => v.resource.body.properties.addressSpace}
}

output "vnet_location" {
  description = "The location of the newly created vNet"
  value       = {for k, v in module.avm-res-network-virtualnetwork : k => v.resource.location}
}

output "subnets" {
  description = "The subnets of the newly created vNet"
  value       = {for k, v in module.avm-res-network-virtualnetwork : k => v.subnets}
}

output "peerings" {
  description = "The peerings of the newly created vNet"
  value       = {for k, v in module.avm-res-network-virtualnetwork : k => v.peerings}
}