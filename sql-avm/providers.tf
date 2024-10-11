# tflint-ignore: terraform_required_providers
terraform {
  required_version = "~> 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.63"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0, < 4.0.0"
    }
    azapi = {
      source = "Azure/azapi"
    }
    validation = {
      source  = "tlkamp/validation"
      version = "~>1.1.1"
    }
  }
}

provider "azurerm" {
  features {}
}
