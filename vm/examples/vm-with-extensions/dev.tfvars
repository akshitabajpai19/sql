location                 = "centralus"
resource_group_name      = "rg-domain"
name                     = "test-domain"
zone                     = 1
subnet_name              = "default"
virtual_machine_size     = "Standard_D2ds_v5"
vnet_name                = "new-vnet"
key_name                 = "newkv19"
vnet_resource_group_name = "rg-domain"
network_interfaces = {
  "nic1" = {
    name = "new-nic"
    ip_configurations = {
      "ipconfig1" = {
        name                          = "new-ip"
        private_ip_subnet_resource_id = "/subscriptions/25538273-e37b-4758-89b1-d352cdac750c/resourceGroups/rg-domain/providers/Microsoft.Network/virtualNetworks/new-vnet/subnets/default"
      }
    }
  }
}
data_disk_enabled = true
data_disk_managed_disks = {
  "de1" = {
    caching              = "None"
    lun                  = 0
    name                 = "disk1"
    storage_account_type = "Standard_LRS"
  }
}
kernel_type = "windows"
extensions = {
  "windows" = {
    kernel_type                 = "windows"
    name                        = "ADDSDomainJoin"
    publisher                   = "Microsoft.Compute"
    type                        = "JsonADDomainExtension"
    type_handler_version        = "1.3"
    auto_upgrade_minor_version  = true
    automatic_upgrade_enabled   = false
    failure_suppression_enabled = true
  }
}
source_image_offer     = "WindowsServer"
source_image_publisher = "MicrosoftWindowsServer"
source_image_sku       = "2022-datacenter-g2"
source_image_version   = "latest"

appid                              = "00000000-0000-0000-0000-000000000000"
appname                            = "new-app"
env                                = "dev"
costCostCenter                     = "123"
costVP                             = "356"
costAppOwnerTech                   = "new"
costAppOwnerManager                = "manager"
costBudgetOwner                    = "owner"
costbaseline                       = "baseline"
resourcetype                       = "resource"
costDivision                       = "1363"
costAllocation                     = "1234"
appFunction                        = "function"
monthlyBudget                      = "123456"
msftmigration                      = "kjasbd"
additionalcontext                  = "01"
managed_by                         = "own"
recovery_resource_group_name       = "rg-domain"
recovery_location                  = "centralus"
recovery_vault_identity_type       = "SystemAssigned"
recovery_enable_diagnostic_setting = false
recovery_services_vault_name       = "any-name"
backup_policy_resource_id          = "/subscriptions/25538273-e37b-4758-89b1-d352cdac750c/resourceGroups/rg-domain/providers/Microsoft.RecoveryServices/vaults/any-name/backupPolicies/new"
