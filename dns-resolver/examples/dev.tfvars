dnsresolver = {
  "dn1" = {
    name                        = "new-dns-resolver"
    location                    = "Central US"
    resource_group_name         = "post-rg"
    virtual_network_resource_id = "/subscriptions/XXXXXXXXXXXXXXXXXXXXXXXXXX/resourceGroups/post-rg/providers/Microsoft.Network/virtualNetworks/vm-test-vnet"
  }

  "dn2" = {
    name                        = "dns-resolver2"
    location                    = "Central US"
    resource_group_name         = "dns-resolver"
    virtual_network_resource_id = "/subscriptions/XXXXXXXXXXXXXXXXXXXXXXXXXX/resourceGroups/dns-resolver/providers/Microsoft.Network/virtualNetworks/new-vm"
    enable_telemetry            = true
    inbound_endpoints = {
      ie01 = {
        name                         = "new-inbound-endpoint"
        subnet_name                  = "default"
        private_ip_allocation_method = "Dynamic"
        private_ip_address           = null
      }
    }
    outbound_endpoints = {
      oe01 = {
        name        = "new-outbound-endpoint"
        subnet_name = "new-subnet"
      }
    }

  }

}
