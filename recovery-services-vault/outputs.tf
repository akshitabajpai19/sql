###############################
# Azure Backup outputs
###############################
output "recovery_vault_name" {
  description = "Azure Recovery Services Vault name"
  value       = azurerm_recovery_services_vault.vault.name
}

output "recovery_vault_id" {
  description = "Azure Recovery Services Vault ID"
  value       = azurerm_recovery_services_vault.vault.id
}

output "vm_backup_policies" {
  value = { for k,v in azurerm_backup_policy_vm.vm_backup_policy : k => v.value.id }
}