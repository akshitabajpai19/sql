#### Ad Object IDs 
data "azurerm_network_security_group" "nsg" {
  count               = (var.nic_nsg != "" ? 1 : 0)
  name                = var.nic_nsg
  resource_group_name = var.nsg_rg != "" ? var.nsg_rg : data.azurerm_resource_group.vnet-rg.name
}

data "azurerm_network_security_group" "nsg_public" {
  count               = (var.public_ip_enabled ? var.public_nsg != "" ? 1 : 0 : 0)
  name                = var.public_nsg
  resource_group_name = var.public_nsg_rg != "" ? var.public_nsg_rg : data.azurerm_resource_group.vnet-public-rg[0].name
}