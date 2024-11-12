location                 = "eastus2"
resourcetype             = "sub"
app_id                   = "SYSGEN2843268158"
appname                  = "example-infra"
env                      = "prod"
costCostCenter           = "H427708790"
costVP                   = "Elsie Mendez"
costAppOwnerTech         = "Corey Cobb"
costAppOwnerManager      = "Hilda Daniel"
costBudgetOwner          = "Marcus Holloway"
costDivision             = "IT & ENGINEERING"
appFunction              = "example general Prod Subscription"
costbaseline             = "2024"
costAllocation           = "sharedcost"
monthlyBudget            = "1000"
subscription_id          = "25538273-e37b-4758-89b1-d352cdac750c"
additionalcontext        = "01"
create_virtual_network   = true
name                     = "vnet-hub-pan-eus2"
vnet_resource_group_name = "rg-vnet-hub-pan-eus2"
address_space            = ["10.121.10.48/28"]
dns_servers              = ["168.63.129.16"]
# subnets = {
#   "subnet-cus" = {
#     name             = "new-subnet"
#     #address_prefixes = ["10.121.10.48"]
#   }
#   "subnet-cus-2" = {
#     name             = "another-subnet"
#     #address_prefixes = ["10.121.10.52/32"]
#   }
# }
tags = {
  msftmigration = "yes"
}