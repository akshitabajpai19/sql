# tflint-ignore: terraform_required_providers
terraform {
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

