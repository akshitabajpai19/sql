# tflint-ignore: terraform_required_providers
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # Stick to 3.89.0 until the following issues are resolved:
      # https://github.com/hashicorp/terraform-provider-azurerm/issues/24793
      # https://github.com/hashicorp/terraform-provider-azurerm/issues/24782
      # Note: Both issues are closed as duplicated one to the other but the
      # situation persists.
      version = "3.89.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.48.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "Infra.Ops-CCOE-HCA-state-management-rg"
    storage_account_name = "infraopstfstatesa"
    container_name       = "tfstates"
    subscription_id      = "8939e7de-7f79-41cf-a8c7-572bce16fd7c"
    key                  = "sub-ccoe-infra-prod-01.tfstate"
  }
}

provider "azurerm" {
  features {
    key_vault {
      recover_soft_deleted_key_vaults = true
      purge_soft_delete_on_destroy    = false
    }
  }
  storage_use_azuread = true
}

provider "azurerm" {
  features {}
  skip_provider_registration = "true"
  subscription_id            = var.subscription_id
  alias                      = "main"
}

provider "azurerm" {
  features {}
  alias                      = "management"
  subscription_id            = var.mgmt_sub_id
  tenant_id                  = var.tenant_id
  skip_provider_registration = true
}

provider "azuread" {
}
