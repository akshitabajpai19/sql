# tflint-ignore: terraform_required_providers
terraform {

  required_version = ">= 1.5"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"

    }
    random = {
      source = "hashicorp/random"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
    azapi = {
      source = "Azure/azapi"
    }
    validation = {
      source  = "tlkamp/validation"
      version = "~> 1.1.1"
    }
  }
}
