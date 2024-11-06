data "azurerm_resource_group" "vnet-rg" {
  name = var.vnet_resource_group_name
}

data "azurerm_resource_group" "vnet-public-rg" {
  count = var.public_ip_enabled ? 1 : 0
  name  = var.public_vnet_rg
}

data "azurerm_key_vault" "vault" {
  count               = var.akv_resource_id == null ? 1 : 0
  name                = local.machine_creds_akv_name
  resource_group_name = local.machine_creds_akv_rg
}

data "azurerm_storage_account" "diagstorage" {
  count               = ((var.storage_analytics_name != null) ? 1 : 0)
  name                = var.storage_analytics_name
  resource_group_name = var.resource_group_storage_name != null ? var.resource_group_storage_name : var.resource_group_name
}

# Networking

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.vnet-rg.name
  virtual_network_name = var.vnet_name
}

data "azurerm_subnet" "subnet_public" {
  count                = var.public_ip_enabled ? 1 : 0
  name                 = var.public_subnet
  resource_group_name  = data.azurerm_resource_group.vnet-public-rg[0].name
  virtual_network_name = var.public_vnet
}

