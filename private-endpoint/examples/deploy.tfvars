create_resource_group   = true
enable_telemetry        = true
resource_group_name     = "avmModuleTesting2"
location                = "EastUS"
enable_private_endpoint = true

private_endpoints = {
  "pe1" = {
    name                        = "private-endpoint-23"
    subresource_names           = ["Blob"]
    is_manual_connection        = false
    private_dns_zone_group_name = "my-private-dns-zone-group1"
  }
}
private_connection_resource_id = ""
# Azure Subscription ID
subscription_id = ""

# Virtual Network Details
virtual_network_rg   = "test-lumen-rg13"
virtual_network_name = "testvnet48"
pe_subnet_name       = "default"
dns_zone_id          = ""
create_dns_zone      = true
domain_name          = "test.project.com"
additionalcontext    = "test"
virtual_network_links = {
  "test-vnet-link" = {
    vnetlinkname = "test-vnet-link2"
    vnetid       = ""
  }
}

# Tag variable values
resourcetype   = "sub"
appid          = "test"
appname        = "exmaple-infra"
env            = "dev"
costCostCenter = "test"
# costVP                               = "vp"
costAppOwnerTech    = "owner"
costAppOwnerManager = "manager"
costBudgetOwner     = "budget owner"
# management_group_name                = "mg-name"
# costDivision                         = "devision-name"
appFunction    = "exmaple general dev Subscription"
costbaseline   = "2024"
costAllocation = "sharedcost"
monthlyBudget  = "1000"