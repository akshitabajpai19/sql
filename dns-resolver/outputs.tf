output "inbound_endpoint_ips" {
  description = "The IP addresses of the inbound endpoints."
  value       = { for k, v in module.avm-res-network-dnsresolver : k => v.inbound_endpoint_ips }
}

output "name" {
  description = "The name of the DNS resolver."
  value       = { for k, v in module.avm-res-network-dnsresolver : k => v.name }
}

output "resource" {
  description = "This is the full output for the resource."
  value       = { for k, v in module.avm-res-network-dnsresolver : k => v.resource }
}

output "resource_id" {
  description = "The ID of the DNS resolver."
  value       = { for k, v in module.avm-res-network-dnsresolver : k => v.resource_id }
}
