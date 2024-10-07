# tflint-ignore: terraform_required_providers
terraform {
  required_version = "~> 1.8"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    azapi = {
      source = "Azure/azapi"
    }
    validation = {
      source  = "tlkamp/validation"
      version = "1.1.1"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "8c5a7b36-81fd-4f19-a1f4-9cdb2a790f8e"
}
