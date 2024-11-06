module "avm-res-compute-virtualmachine" {

  source = "github.com/CenturyLink/tf-modules-azure//key-vault?ref=2.3.0"

  additionalcontext                       = "01"
  appFunction                             = var.appFunction
  appid                                   = var.appid
  appname                                 = var.appname
  costAllocation                          = var.costAllocation
  costAppOwnerManager                     = var.costAppOwnerManager
  costAppOwnerTech                        = var.costAppOwnerTech
  costBudgetOwner                         = var.costBudgetOwner
  costCostCenter                          = var.costCostCenter
  costDivision                            = var.costDivision
  costVP                                  = var.costVP
  costbaseline                            = var.costbaseline
  enable_boot_diagnostics                 = true
  env                                     = var.env
  generate_admin_password_or_ssh_key      = true
  kernel_type                             = "linux"
  location                                = var.location
  machine_creds_akv_rg                    = var.infra_rg_app_name
  monthlyBudget                           = var.monthlyBudget
  operating_system_disk_cache             = "ReadWrite"
  operating_system_disk_size_gb           = "128"
  operating_system_disk_type              = "StandardSSD_LRS"
  operating_system_disk_write_accelerator = false
  recovery_sku                            = "Standard"
  resource_group_name                     = var.infra_rg_app_name
  vm_admin_pwd_keyvault_name              = module.akv-example-infra-prod-01.name
  resourcetype                            = "vm"
  secure_boot_enabled                     = true
  soft_delete_enabled                     = true
  source_image_offer                      = "Oracle-Linux"
  source_image_publisher                  = "Oracle"
  source_image_sku                        = "ol89-lvm-gen2"
  source_image_version                    = "8.9.5"
  subnet_name                             = data.azurerm_subnet.private_endpoint.name
  tags                                    = local.tags
  team_spn                                = []
  team_vm_admin_groups                    = [var.vm_rbac_admin_group]
  team_vm_contributor_groups              = [var.vm_cluster_admin_group]
  team_vm_reader_groups                   = [var.vm_cluster_admin_group, var.vm_rbac_reader_group, var.vm_rbac_writer_group, var.vm_rbac_admin_group]
  team_vm_userlogin_groups                = [var.vm_cluster_user_group]
  total_machine_count                     = 1
  ultra_ssd_enabled                       = false
  virtual_machine_size                    = "Standard_D4s_v5"
  vnet_name                               = data.azurerm_virtual_network.vnet.name
  vnet_resource_group_name                = data.azurerm_virtual_network.vnet.resource_group_name
  backup_policy_type                      = "V2"

  providers = {
    azurerm = azurerm.main
  }

  depends_on = [module.akv-bpi-dev-01]
}