module "avm-res-network-nsg" {
  count               = var.nic_nsg == "" ? 1 : 0
  source              = "Azure/avm-res-network-networksecuritygroup/azurerm"
  version             = "0.2.0"
  location            = data.azurerm_resource_group.vnet-rg.location
  name                = "nsg-${local.naming}"
  resource_group_name = data.azurerm_resource_group.vnet-rg.name
  diagnostic_settings = var.nsg_diagnostic_settings
  enable_telemetry    = false
  role_assignments    = local.nsg_role_assigments
  security_rules      = local.security_rules
  tags                = local.tags_public
}
