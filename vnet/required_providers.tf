# tflint-ignore: terraform_required_providers
terraform {
  required_version = "~> 1.5"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>3.63"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 1.15"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
    validation = {
      source  = "tlkamp/validation"
      version = "~> 1.1.1"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
  
}