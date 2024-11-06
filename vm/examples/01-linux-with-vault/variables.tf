variable "tf_team_group" {
  description = "List of User Ids for the Terraform Team"
  type        = list(string)
}

variable "vm_cluster_admin_group" {
  description = "Group name for the VM Admins"
  type        = string
}

variable "vm_cluster_user_group" {
  description = "Group name for the VM Users"
  type        = string
}

variable "vm_rbac_admin_group" {
  description = "Group name for the VM Admins"
  type        = string
}

variable "vm_rbac_reader_group" {
  description = "Group name for the VM Readers"
  type        = string
}

variable "vm_rbac_writer_group" {
  description = "Group name for the AKS RBAC Writers"
  type        = string
}