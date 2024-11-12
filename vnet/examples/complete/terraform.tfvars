location                 = "northcentralus"
resourcetype             = "sub"
app_id                    = "SYSGEN2843268158"
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
subscription_id          = "00000000-0000-0000-0000-000000000000"
additionalcontext        = "01"
vnet_resource_group_name = "rg-vnet-exmaple-infra-prod-01"
address_space            = ["172.19.81.0/24", "148.155.171.128/25", "148.155.171.96/27"]
dns_servers              = ["8.30.135.252", "8.30.135.253", "151.116.17.28"]
subnets = {
  "subnet-cus" = {
    resourcetype      = "snet-pe"
    additionalcontext = "01"
    address_prefixes  = ["148.155.149.48/29"]
  },
  "subnet-cus-db-auth" = {
    name              = "snet-pe-auth-custom-name-example"
    address_prefixes  = ["148.155.150.192/26"]
    service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
    delegations = {
      "del-example-prod-01" = {
        name = "Microsoft.Databricks/workspaces",
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
          "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
        ]
      }
    }
  }
}

bgp_community = null
ddos_protection_plan = {
  id     = "ddos-protection-plan-example"
  enable = true
}
diagnostic_settings = {
  sendToLogAnalytics = {
    name                           = "sendToLogAnalytics"
    workspace_resource_id          = "log-analytics-workspace-resource-id"
    log_analytics_destination_type = "Dedicated"
  }
}
enable_telemetry     = true
enable_vm_protection = false
encryption = {
  enabled     = true
  enforcement = "AllowUnencrypted"
}
extended_location       = null
flow_timeout_in_minutes = 4
lock = {
  kind = "CanNotDelete"
  name = "lock-example"
}
peerings = {
  peertovnet1 = {
    name                                  = "peer-vnet2-to-vnet1"
    remote_virtual_network_resource_id    = "sample-vnet1-resource_id"
    allow_forwarded_traffic               = true
    allow_gateway_transit                 = true
    allow_virtual_network_access          = true
    do_not_verify_remote_gateways         = false
    enable_only_ipv6_peering              = false
    use_remote_gateways                   = false
    create_reverse_peering                = true
    reverse_name                          = "peer-vnet1-to-vnet2"
    reverse_allow_forwarded_traffic       = false
    reverse_allow_gateway_transit         = false
    reverse_allow_virtual_network_access  = true
    reverse_do_not_verify_remote_gateways = false
    reverse_enable_only_ipv6_peering      = false
    reverse_use_remote_gateways           = false
  }
}
role_assignments = {
  role1 = {
    principal_id               = "sample-principal-id"
    role_definition_id_or_name = "Contributor"
  }
}
