output "resource" {
  description = "This output is the full output for the resource to allow flexibility to reference all possible values for the resource. Example usage: module.<modulename>.resource.id"
  value       = { for k, v in module.avm-res-desktopvirtualization-scalingplan : k => v.resource }
}

output "resource_id" {
  description = "This output is the full output for the resource to allow flexibility to reference all possible values for the resource. Example usage: module.<modulename>.resource.id"
  value       = { for k, v in module.avm-res-desktopvirtualization-scalingplan : k => v.resource_id }
}
