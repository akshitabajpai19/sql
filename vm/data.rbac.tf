locals {
  default_tf_group       = ["azad.ccoe.contributor"]
  default_owner_group    = ["azad.itops.owners"]
  default_deployment_spn = concat(["spn-acf-dev-terraform-automation", "spn-acf-prod-rbac-terraform-automation"], var.team_spn)
}


# NSG RBAC

data "azuread_group" "default_contrib_group" {
  count        = length(concat(local.default_owner_group, local.default_tf_group))
  display_name = concat(local.default_owner_group, local.default_tf_group)[count.index]
}

data "azuread_service_principal" "ad_default_spn" {
  count        = length(local.default_deployment_spn)
  display_name = local.default_deployment_spn[count.index]
}


# COMPUTE RBAC

data "azuread_group" "vmcontributor" {
  count        = length(concat(local.default_owner_group, local.default_tf_group, var.team_vm_contributor_groups))
  display_name = concat(local.default_owner_group, local.default_tf_group, var.team_vm_contributor_groups)[count.index]
}

data "azuread_group" "vmreader" {
  count        = length(var.team_vm_reader_groups)
  display_name = var.team_vm_reader_groups[count.index]
}


data "azuread_group" "vmuserlogin" {
  count        = length(var.team_vm_userlogin_groups)
  display_name = var.team_vm_userlogin_groups[count.index]
}

data "azuread_group" "vmadminlogin" {
  count        = length(var.team_vm_admin_groups)
  display_name = var.team_vm_admin_groups[count.index]
}
