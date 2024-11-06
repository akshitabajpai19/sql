output "vm_details" {
  description = "Returns the details of the virtual machine"
  value = {
    for key, vm in module.avm-res-compute-virtualmachine :
    key => {
      admin_password                  = vm.admin_passwords
      admin_ssh_keys                  = vm.admin_ssh_keys
      admin_username                  = vm.admin_username
      data_disks                      = vm.data_disks
      name                            = vm.name
      network_interfaces              = vm.network_interfaces
      public_ips                      = vm.public_ips
      resource                        = vm.resource
      resource_id                     = vm.resource_id
      system_assigned_mi_principal_id = vm.system_assigned_mi_principal_id
      virtual_machine_azurerm         = vm.virtual_machine_azurerm
    }
  }
  sensitive = true
}

output "vault_details" {
  description = "All values related to the backup vault"
  value = {
    for key, vault in module.avm-res-compute-virtualmachine :
    key => {
      backup_vault_id   = vault.backup_vault_id
      backup_vault_name = vault.backup_vault_name
    }
  }
}

output "avm_nsg" {
  description = "The network security group associated with the virtual machine"
  value = {
    for key, nsg in module.avm-res-compute-virtualmachine :
    key => {
      nsg_name        = nsg.nsg_name
      nsg_resource_id = nsg.nsg_resource_id
      nsg_resource    = nsg.nsg_resource
    }
  }
}