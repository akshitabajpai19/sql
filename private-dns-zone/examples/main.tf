module "private_dns_zones" {
  source                = "../"
  enable_telemetry      = var.enable_telemetry
  resource_group_name   = var.resource_group_name
  domain_name           = var.domain_name
  soa_record            = var.soa_record
  virtual_network_links = var.virtual_network_links
  a_records             = var.a_records
  aaaa_records          = var.aaaa_records
  cname_records         = var.cname_records
  mx_records            = var.mx_records
  ptr_records           = var.ptr_records
  srv_records           = var.srv_records
  txt_records           = var.txt_records
}