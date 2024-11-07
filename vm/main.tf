resource "azurerm_proximity_placement_group" "primary" {
  count               = ((var.proximity_placement_group == null && var.capacity_reservation_group_resource_id == null && var.total_machine_count > 1) ? 1 : 0)
  name                = "pgp-shir-${local.naming}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags
  lifecycle {
    ignore_changes = [
      tags["provisioned_date"]
    ]

  }
}


module "avm-res-compute-virtualmachine" {
  source  = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "0.15.1"

  depends_on = [module.recovery,
    azurerm_proximity_placement_group.primary,
    module.avm-res-network-nsg
  ]


  count                        = var.total_machine_count
  location                     = var.location
  name                         = format("${local.virtual_machine_name}-%03s", (count.index + 1))
  network_interfaces           = local.network_interfaces
  resource_group_name          = var.resource_group_name
  zone                         = var.availability_zone
  additional_unattend_contents = var.additional_unattend_contents
  admin_username               = local.admin_username
  allow_extension_operations   = true
  azure_backup_configurations = {
    standard_backup_configuration = {
      resource_group_name       = var.resource_group_vault_recovery != "" ? var.resource_group_vault_recovery : var.resource_group_name
      recovery_vault_name       = var.recovery_services_vault_name != "" ? var.recovery_services_vault_name : local.recovery_name
      backup_policy_resource_id = var.backup_policy_resource_id != "" ? var.backup_policy_resource_id : module.recovery.vm_backup_policies[0].id
    }
  }

  boot_diagnostics                                       = var.enable_boot_diagnostics
  boot_diagnostics_storage_account_uri                   = var.storage_analytics_name != null ? data.azurerm_storage_account.diagstorage[0].primary_blob_endpoint : null
  bypass_platform_safety_checks_on_user_schedule_enabled = var.bypass_platform_safety_checks_on_user_schedule_enabled

  capacity_reservation_group_resource_id = var.capacity_reservation_group_resource_id

  computer_name = local.computer_name
  custom_data   = var.custom_data


  data_disk_managed_disks = var.data_disk_enabled ? {
    data = {
      caching              = var.data_disk_caching
      lun                  = var.data_disk_machine_lun
      name                 = format("disk-${local.virtual_machine_name}-%03s", (count.index + 1))
      storage_account_type = var.data_disk_type
      create_option        = var.data_disk_create_option
      disk_size_gb         = var.data_disk_size_gb
    }
  } : {}

  dedicated_host_group_resource_id = var.dedicated_host_group_resource_id
  dedicated_host_resource_id       = var.dedicated_host_resource_id

  diagnostic_settings = var.diagnostic_settings

  disable_password_authentication = var.disable_password_authentication
  disk_controller_type            = var.disk_controller_type

  edge_zone = var.edge_zone

  enable_telemetry = false

  encryption_at_host_enabled = var.encryption_at_host_enabled

  eviction_policy = var.eviction_policy

  #extensions = var.kernel_type == "linux" ? local.linux_extensions : local.windows_extensions
  extensions = var.extensions


  generate_admin_password_or_ssh_key = var.generate_admin_password_or_ssh_key

  generated_secrets_key_vault_secret_config = {
    key_vault_resource_id = var.akv_resource_id != null ? var.akv_resource_id : try(data.azurerm_key_vault.vault[0].id, null)
    name                  = "${local.computer_name}--username-credentials"
    expiration_date       = "365"
  }

  lock = var.lock

  managed_identities = local.identities

  max_bid_price = var.max_bid_price

  os_disk = {
    caching                   = var.operating_system_disk_cache
    storage_account_type      = var.operating_system_disk_type
    disk_size_gb              = var.operating_system_disk_size_gb
    write_accelerator_enabled = var.operating_system_disk_write_accelerator
    name                      = format("osdisk-${local.virtual_machine_name}-%03s", (count.index + 1))
  }

  os_type = var.kernel_type == "linux" ? "Linux" : "Windows"

  priority = var.priority

  proximity_placement_group_resource_id = var.proximity_placement_group != null ? var.proximity_placement_group : var.total_machine_count > 1 ? azurerm_proximity_placement_group.primary[0].id : null

  public_ip_configuration_details = {
    sku = var.public_ip_sku
  }
  role_assignments = merge({
    for group in data.azuread_group.vmadminlogin :
    "vm_contributor_rbac-${group.display_name}" => {
      description                = "Virtual Machine Contributor Role Assignment for ${group.display_name}"
      principal_id               = group.id
      role_definition_id_or_name = "Virtual Machine Contributor"
    }
    },
    {
      for group in data.azuread_group.vmreader :
      "vm_reader_rbac-${group.display_name}" => {
        description                = "Virtual Machine Reader Role Assignment for ${group.display_name}"
        principal_id               = group.id
        role_definition_id_or_name = "Reader"
      }
    },
    {
      for group in data.azuread_group.vmuserlogin :
      "vm_user_rbac-${group.display_name}" => {
        description                = "Virtual Machine User Login Role Assignment for ${group.display_name}"
        principal_id               = group.id
        role_definition_id_or_name = "Virtual Machine User Login"
      }
    },
    {
      for group in data.azuread_group.vmadminlogin :
      "vm_admin_rbac-${group.display_name}" => {
        description                = "Virtual Machine Admin Role Assignment"
        principal_id               = group.id
        role_definition_id_or_name = "Virtual Machine Administrator Login"
      }
    }
  )
  # role_assignments = var.role_assignments

  secure_boot_enabled = var.secure_boot_enabled

  shutdown_schedules = {
    dev_test_global_vm_shutdown_schedule = {
      daily_recurrence_time = var.auto_shutdown_time
      enabled               = var.auto_shutdown_enabled
      location              = var.location
      notification_settings = {
        enabled         = var.auto_shutdown_notification_enabled
        time_in_minutes = var.auto_shutdown_notification_time
        webhook_url     = var.auto_shutdown_notification_webhook_url
      }
      timezone = var.auto_shutdown_timezone
      tags     = local.tags_public
    }
  }

  sku_size = var.virtual_machine_size

  source_image_reference = {
    offer     = var.source_image_offer
    publisher = var.source_image_publisher
    sku       = var.source_image_sku
    version   = var.source_image_version
  }

  #tags = local.tags_public

  tags = merge(var.tags, local.tags_public)

  timezone = "UTC"
  vm_additional_capabilities = {
    ultra_ssd_enabled = var.ultra_ssd_enabled
  }

  plan = var.plan
}
