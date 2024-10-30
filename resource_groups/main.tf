module "avm-res-resources-resourcegroup" {
  source           = "Azure/avm-res-resources-resourcegroup/azurerm"
  version          = "0.1.0"
  enable_telemetry = var.enable_telemetry
  location         = var.location
  name             = local.name
  role_assignments = var.role_assignments
  tags             = local.tags
  lock             = var.lock
}
