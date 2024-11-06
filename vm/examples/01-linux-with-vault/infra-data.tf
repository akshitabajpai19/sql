data "azurerm_resource_group" "rg_vnet" {
  name     = var.infra_rg_vnet_name
  provider = azurerm.main
}

data "azurerm_virtual_network" "vnet" {
  name                = var.infra_vnet_name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  provider            = azurerm.main
}

data "azurerm_subnet" "private_endpoint" {
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  name                 = var.infra_subnet_pe_name
  provider             = azurerm.main
}


data "azurerm_private_dns_zone" "kv" {
  provider            = azurerm.management
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.private_dns_rg
}


data "azurerm_resource_group" "rg_application" {
  name     = var.infra_rg_app_name
  provider = azurerm.main
}