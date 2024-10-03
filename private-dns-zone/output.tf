output "a_record_outputs" {
  value = module.avm-res-network-privatednszone.a_record_outputs
}

output "aaaa_record_outputs" {
  value = module.avm-res-network-privatednszone.aaaa_record_outputs
}

output "cname_record_outputs" {
  value = module.avm-res-network-privatednszone.cname_record_outputs
}

output "mx_record_outputs" {
  value = module.avm-res-network-privatednszone.mx_record_outputs
}

output "ptr_record_outputs" {
  value = module.avm-res-network-privatednszone.ptr_record_outputs
}

output "srv_record_outputs" {
  value = module.avm-res-network-privatednszone.srv_record_outputs
}

output "txt_record_outputs" {
  value = module.avm-res-network-privatednszone.txt_record_outputs
}

output "virtual_network_link_outputs" {
  value = module.avm-res-network-privatednszone.virtual_network_link_outputs
}

output "dns_zone_name" {
  value = module.avm-res-network-privatednszone.name
}

output "dns_zone_id" {
  value = module.avm-res-network-privatednszone.resource_id
}

output "privatednszone" {
  description = "The private dns zone details"
  value = {
    a_record_outputs             = module.avm-res-network-privatednszone.a_record_outputs
    aaaa_record_outputs          = module.avm-res-network-privatednszone.aaaa_record_outputs
    cname_record_outputs         = module.avm-res-network-privatednszone.cname_record_outputs
    mx_record_outputs            = module.avm-res-network-privatednszone.mx_record_outputs
    ptr_record_outputs           = module.avm-res-network-privatednszone.ptr_record_outputs
    srv_record_outputs           = module.avm-res-network-privatednszone.srv_record_outputs
    virtual_network_link_outputs = module.avm-res-network-privatednszone.virtual_network_link_outputs
    dns_zone_id                  = module.avm-res-network-privatednszone.resource_id
    dns_zone_name                = module.avm-res-network-privatednszone.name
    txt_record_outputs           = module.avm-res-network-privatednszone.txt_record_outputs
  }
}
