output "inbound_endpoint_ips" {
  description = "The IP addresses of the inbound endpoints."
  value       = module.dns_resolver.inbound_endpoint_ips
}

output "name" {
  description = "The name of the DNS resolver."
  value       = module.dns_resolver.name
}

output "resource" {
  description = "This is the full output for the resource."
  value       = module.dns_resolver.resource
}

output "resource_id" {
  description = "The ID of the DNS resolver."
  value       = module.dns_resolver.resource_id
}
