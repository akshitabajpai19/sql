sql_servers = {
  server01 = {
    name                           = "akshitasqlserver01"
    sql_server_resource_group_name = "sql-rg"
    location                       = "Central US"
    administrator_login_name       = "newuser"
    sql_server_keyvault_name       = "csi-aks-kv-02"
    sql_server_keyvault_rg_name    = "csi-key-vault"
    version                        = "12.0"
    public_network_access_enabled  = false
    minimum_tls_version            = "1.2"
    # tags = {
    #   environment = "production"
    #   department  = "IT"
    # }
    additionalcontext = 01
  }
  server02 = {
    name                           = "akshitasqlserver02"
    sql_server_resource_group_name = "sql-rg"
    location                       = "Central India"
    administrator_login_name       = "newuser"
    sql_server_keyvault_name       = "csi-aks-kv-02"
    sql_server_keyvault_rg_name    = "csi-key-vault"
    version                        = "12.0"
    public_network_access_enabled  = false
    minimum_tls_version            = "1.2"
    # tags = {
    #   environment = "production"
    #   department  = "IT"
    # }
    additionalcontext = 01
  }
}

sql_server_private_endpoints = {
  sqlpe01 = {
    private_endpoints = {
      "pe1" = {
        name                        = "private-endpoint-23"
        subresource_names           = ["sqlServer"]
        is_manual_connection        = false
        private_dns_zone_group_name = "my-private-dns-zone-group1"
      }
    }
    sql_server_key                       = "server01"
    subscription_id                      = "XXXXXX-XXXXX-XXXXXX"
    pe_subnet_name                       = "default"
    virtual_network_name                 = "testvnet48"
    virtual_network_rg                   = "test-lumen-rg13"
    private_endpoint_resource_group_name = "private-rg-01"
    #private_connection_resource_id       = ""
    location                             = "Central US"
    dns_zone_id                          = "/subscriptions/XXXXXX-XXXXX-XXXXXX/resourceGroups/private-rg-01/providers/Microsoft.Network/privateDnsZones/test.project.com"
    create_dns_zone                      = false
    domain_name                          = "test.project.com"
    additionalcontext                    = "test"
    virtual_network_links = {
      "test-vnet-link" = {
        vnetlinkname = "test-vnet-link2"
        vnetid       = "/subscriptions/XXXXXX-XXXXX-XXXXXX/resourceGroups/vnet-test/providers/Microsoft.Network/virtualNetworks/vnet123"
      }
    }
  }
  sqlpe02 = {
    private_endpoints = {
      "pe1" = {
        name                        = "private-endpoint-2"
        subresource_names           = ["sqlServer"]
        is_manual_connection        = false
        #private_dns_zone_group_name = "my-private-dns-zone-group1"
      }
    }
    sql_server_key                       = "server02"
    subscription_id                      = "XXXXXX-XXXXX-XXXXXX"
    pe_subnet_name                       = "default"
    virtual_network_name                 = "testvnet48"
    virtual_network_rg                   = "test-lumen-rg13"
    private_endpoint_resource_group_name = "private-rg-01"
    #private_connection_resource_id       = ""
    location                             = "Central US"
    dns_zone_id                          = "/subscriptions/XXXXXX-XXXXX-XXXXXX/resourceGroups/private-rg-01/providers/Microsoft.Network/privateDnsZones/test.project.com"
    create_dns_zone                      = false
    domain_name                          = "test.project.com"
    additionalcontext                    = "test"
    virtual_network_links = {
      "test-vnet-link" = {
        vnetlinkname = "test-vnet-link2"
        vnetid       = "/subscriptions/XXXXXX-XXXXX-XXXXXX/resourceGroups/vnet-test/providers/Microsoft.Network/virtualNetworks/vnet123"
      }
    }
  }
}

location            = "Central US"
appid               = "t0000000"
appname             = "newapp"
env                 = "dev"
costAppOwnerTech    = "new"
costAppOwnerManager = "manager"
costBudgetOwner     = "owner"
costbaseline        = "baseline"
resourcetype        = "resource"
costDivision        = "t363"
costAllocation      = "t234"
appFunction         = "function"
monthlyBudget       = "yh23456"
costCostCenter      = "hjbd"
costVP              = "sjdhcj"