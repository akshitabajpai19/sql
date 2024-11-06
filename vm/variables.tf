## Naming and Tags ##

variable "key_name" {
  type = string
}

variable "name" {
  type        = string
  description = "The name to use when creating the virtual machine."
  nullable    = false

  validation {
    condition     = can(regex("^.{1,64}$", var.name))
    error_message = "virtual machine names for linux must be between 1 and 64 characters in length. Virtual machine name for windows must be between 1 and 20 characters in length."
  }
}

variable "location" {
  description = "The Azure region where resources will be deployed"
  type        = string
}

variable "resourcetype" {
  description = "the resource type being deployed see naming standards for example"
  type        = string
  default     = "vm"
}

variable "appid" {
  description = "The related application for resources. Used for tagging and naming purposes."
  type        = string
}

variable "appname" {
  description = "the app name for the resources.  Used for tagging and naming purposes"
  type        = string
}

variable "env" {
  description = "The environment code the for resources. Used for tagging and naming purposes."
  type        = string
}

variable "costCostCenter" {
  description = "The cost center code for resources. Used for tagging and naming purposes."
  type        = string
}

variable "costVP" {
  description = "The cost vp for resources. Used for tagging purposes."
  type        = string
}

variable "costAppOwnerTech" {
  description = "The app owner responsible for resources. Used for tagging and naming purposes."
  type        = string
}

variable "costAppOwnerManager" {
  description = "The app owner manager responsible for resources. Used for tagging purposes."
  type        = string
}

variable "costBudgetOwner" {
  description = "The budget owner responsible for resources. Used for tagging purposes."
  type        = string
}

variable "additionalcontext" {
  description = "used for naming purposes such as 01 or 02"
  type        = string
}

variable "costDivision" {
  description = "cost division"
  type        = string
}

variable "costAllocation" {
  description = "can only be sharedcosts or chargeback"
  type        = string
}

variable "appFunction" {
  description = "app function"
  type        = string
}

variable "monthlyBudget" {
  description = "monthly budget"
  type        = string
}

variable "costbaseline" {
  description = "year resource created"
  type        = string
}

variable "managed_by" {
  description = "resource group is managed by"
  type        = string
  default     = null
}

variable "vnet_resource_group_name" {
  description = "resource group name where the vnet is installed"
  type        = string
}

variable "storage_analytics_name" {
  description = "The Storage Account's Blob Name which should hold the virtual machine's diagnostic files. If null it will use managed ones"
  type        = string
  default     = null
}

variable "resource_group_storage_name" {
  description = "The Storage Account's resurce name. Defaault to deployment resource group"
  type        = string
  default     = null
}

# VM Control Variables
variable "total_machine_count" {
  description = "Number of VMs to be provisioned"
  type        = number
  default     = 1
}
# Operating System Disck

variable "operating_system_disk_write_accelerator" {
  description = "Should Write Accelerator be Enabled for this OS Disk?"
  type        = bool
  default     = false
}

variable "enable_boot_diagnostics" {
  description = "Whether to enable boot diagnostics on the virtual machine."
  type        = bool
  default     = true
}


variable "data_disk_create_option" {
  description = "the Create Option of the Data Disk, such as Empty or Attach. Defaults to Attach. Changing this forces a new resource to be created."
  type        = string
  default     = "Empty"

  validation {
    condition     = (contains(["empty", "attach"], lower(var.data_disk_create_option)))
    error_message = "Data Dosk Create Option only be \"Empty\" or \"Attach\"."
  }
}


variable "data_disk_size_gb" {
  description = "The data size of disk to be create"
  type        = number
  default     = 256
}

variable "data_disk_enabled" {
  description = "Create and attach a data disk?"
  type        = bool
  default     = false
}

variable "data_disk_machine_lun" {
  description = "The Logical Unit Number of the Data Disk. Changing this forces a new resource to be created."
  type        = string
  default     = "0"
}

variable "data_disk_caching" {
  description = "The Caching of the Data Disk. Possible values are None, ReadOnly, ReadWrite. Changing this forces a new resource to be created."
  type        = string
  default     = "None"

  validation {
    condition     = (contains(["none", "readonly", "readwrite"], lower(var.data_disk_caching)))
    error_message = "OS Disk cache can only be \"None\", \"ReadOnly\" or \"ReadWrite\"."
  }
}

variable "data_disk_type" {
  description = "Type of storage account to use with the Data disk - Options: Standard_LRS, StandardSSD_LRS or Premium_LRS"
  type        = string
  default     = "Premium_LRS"

  validation {
    condition     = (contains(["standard_lrs", "standardssd_lrs", "premium_lrs", "ultrassd_lrs"], lower(var.data_disk_type)))
    error_message = "Public IP sku can only be \"Standard_LRS\", \"StandardSSD_LRS\", \"Premium_LRS\" or \"UltraSSD_LRS\"."
  }
}

variable "recovery_sku" {
  description = "The recovery services vault SKU to use"
  type        = string
  default     = "Standard"
}

variable "resource_group_name" {
  description = "name of the resource group where to place the vm"
  type        = string
}

variable "vm_admin_pwd_keyvault_secret_name" {
  description = "keyvault secret name for the vm admin password"
  type        = string
  default     = ""
}

# VM Size
variable "virtual_machine_size" {
  description = "Instance size to be provisioned"
  type        = string
}

# VM Type
variable "kernel_type" {
  description = "Virtual machine kernel - windows or linux"
  default     = "linux"
  type        = string

  validation {
    condition     = (contains(["windows", "linux"], lower(var.kernel_type)))
    error_message = "Kernel type can only be \"windows\" or \"linux\"."
  }
}

# Custom Machine Image
variable "custom_image_id" {
  description = "Custom machine image ID"
  type        = string
  default     = null
}

# Custom User Data
variable "custom_data" {
  description = "The Base64-Encoded Custom Data which should be used for this Virtual Machine"
  type        = string
  default     = null
}

# Operating System
variable "source_image_publisher" {
  description = "Operating System Publisher"
  type        = string
  default     = null
}

variable "source_image_offer" {
  description = "Operating System Name"
  type        = string
  default     = null
}

variable "source_image_sku" {
  description = "Operating System SKU"
  type        = string
  default     = null
}

variable "source_image_version" {
  description = "Operating System Version"
  type        = string
  default     = "latest"
}

# Operating System Disk
variable "operating_system_disk_cache" {
  description = "Type of caching to use on the OS disk - Options: None, ReadOnly or ReadWrite"
  type        = string
  default     = "ReadWrite"

  validation {
    condition     = (contains(["none", "readonly", "readwrite"], lower(var.operating_system_disk_cache)))
    error_message = "OS Disk cache can only be \"None\", \"ReadOnly\" or \"ReadWrite\"."
  }
}

variable "operating_system_disk_type" {
  description = "Type of storage account to use with the OS disk - Options: Standard_LRS, StandardSSD_LRS or Premium_LRS"
  type        = string
  default     = "StandardSSD_LRS"

  validation {
    condition     = (contains(["standard_lrs", "standardssd_lrs", "premium_lrs", "ultrassd_lrs"], lower(var.operating_system_disk_type)))
    error_message = "Public IP sku can only be \"Standard_LRS\", \"StandardSSD_LRS\", \"Premium_LRS\" or \"UltraSSD_LRS\"."
  }
}

variable "operating_system_disk_size_gb" {
  description = "Size of the internal OS disk in gigabytes"
  type        = number
  default     = null
}

# Credentials
variable "admin_username" {
  description = "Default Username - Random if left blank"
  type        = string
  default     = ""
}

variable "admin_password" {
  description = "Default Password - Random if left blank. For Linux, need to have disable_password_authentication set to false"
  type        = string
  default     = ""
  sensitive   = true
}

resource "validation_warning" "admin_password" {
  condition = var.admin_password != ""
  summary   = "The admin_password input variable is deprecated. v1.0 ignores it and v2.0 will delete this variable"
}


variable "admin_ssh_public_key" {
  description = "(Linux) Public SSH Key - Generated if left blank"
  type        = string
  default     = ""
  sensitive   = true
}

resource "validation_warning" "admin_ssh_public_key" {
  condition = var.admin_ssh_public_key != ""
  summary   = "The admin_ssh_public_key input variable is deprecated. v1.0 ignores it and v2.0 will delete this variable"
}



variable "disable_password_authentication" {
  description = "(Linux) Disable Password Authentication"
  type        = bool
  default     = true
}

# Networking

variable "vnet_name" {
  description = "Specifies the name of the Virtual Network this Subnet is located within"
  type        = string
}

variable "subnet_name" {
  description = "Specifies the name of the Subnet."
  type        = string
}

variable "accelerated_networking" {
  description = "Enable accelerated networking?"
  type        = bool
  default     = false
}

variable "ultra_ssd_enabled" {
  description = "Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine."
  type        = bool
  default     = false
}

variable "availability_zone" {
  description = "The Zone in which this Virtual Machine should be created. Changing this forces a new resource to be created."
  type        = number
  default     = null
}

variable "nic_nsg" {
  description = "NIC NSG for the Virtual machine NIC"
  type        = string
  default     = ""
}

variable "nsg_rg" {
  description = "Resource Group for the NSG"
  type        = string
  default     = ""
}

# VM Identity
variable "identity_type" {
  description = "The Managed Service Identity Type of this Virtual Machine. Possible values are SystemAssigned (where Azure will generate a Managed Identity for you), UserAssigned (where you can specify the Managed Identities ID)."
  type        = string
  default     = "SystemAssigned"

  validation {
    condition     = (contains(["systemassigned", "userassigned"], lower(var.identity_type)))
    error_message = "The identity type can only be \"UserAssigned\" or \"SystemAssigned\"."
  }
}

variable "identity_ids" {
  description = "Specifies a list of user managed identity ids to be assigned to the VM"
  type        = list(string)
  default     = []
}


variable "managed_identities" {
  type = object({
    system_assigned            = optional(bool, false)
    user_assigned_resource_ids = optional(set(string), [])
  })
  default     = {}
  description = <<IDENTITY
An object that sets the managed identity configuration for the virtual machine being deployed. Be aware that capabilities such as the Azure Monitor Agent and Role Assignments require that a managed identity has been configured.

- `system_assigned`            = (Optional) Specifies whether the System Assigned Managed Identity should be enabled.  Defaults to false. 
- `user_assigned_resource_ids` = (Optional) Specifies a set of User Assigned Managed Identity IDs to be assigned to this Virtual Machine.

Example Inputs:
```hcl
#default system managed identity
managed_identities = {
  system_assigned = true
}
#user assigned managed identity only
managed_identities           = {
  user_assigned_resource_ids = ["<azure resource ID of a user assigned managed identity>"]
}
#user assigned and system assigned managed identities
managed_identities  = {
  system_assigned            = true
  user_assigned_resource_ids = ["<azure resource ID of a user assigned managed identity>"]
}
```
IDENTITY
  nullable    = false
}

# Auto Shutdown TAGS

variable "auto_shutdown_enabled" {
  description = "Enable Auto Shutdown?"
  type        = bool
  default     = false
}

variable "auto_shutdown_time" {
  description = "Time to shutdown the VM - Format: HHMM"
  type        = string
  default     = "0000"
}

variable "auto_shutdown_timezone" {
  description = "Timezone to shutdown the VM - Format: UTC, GMT, etc https://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/"
  type        = string
  default     = "UTC"
}

variable "auto_shutdown_notification_enabled" {
  description = "Enable Auto Shutdown Notification"
  type        = bool
  default     = false
}

variable "auto_shutdown_notification_time" {
  description = "Time to send the shutdown notification prior shutdown 0 - 120 minutes"
  type        = string
  default     = null
}

variable "auto_shutdown_notification_webhook_url" {
  description = "Webhook URL to send the shutdown notification"
  type        = string
  default     = null
}


# AKV Variables

variable "vm_admin_pwd_keyvault_name" {
  description = "keyvault name for the vm admin password"
  type        = string
  default     = ""
}

variable "machine_creds_akv_rg" {
  description = "Resource Group of the AKV to store the machine credentials"
  type        = string
  default     = ""
}

variable "akv_resource_id" {
  description = "Resource ID of the AKV to store the machine credentials. Use this one in case that the AKV is in a different subscription"
  type        = string
  default     = null
}

variable "aad_ssh_login_extension_version" {
  description = "VM Extension version for Azure Active Directory SSH Login extension"
  type        = string
  default     = "1.0"
}



variable "tags" {
  type        = map(any)
  description = "tags to add to the vm"
  default     = null
}


variable "team_spn" {
  description = "The Service Principal Name of the team that will be able to modifyteam resources"
  type        = list(string)
  default     = []
}


variable "team_vm_contributor_groups" {
  description = "The Contributor Group of the team that will be able to modify team resources"
  type        = list(string)
  default     = []
}

variable "team_vm_reader_groups" {
  description = "The Reader Group of the team that will be able to modify team resources"
  type        = list(string)
  default     = []
}

variable "team_vm_userlogin_groups" {
  description = "The User Login Group of the team that will be able to modify team resources"
  type        = list(string)
  default     = []
}

variable "team_vm_admin_groups" {
  description = "The Admin Group of the team that will be able to modify team resources"
  type        = list(string)
  default     = []
}

