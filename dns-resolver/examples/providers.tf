terraform {
  required_version = "~> 1.5"
  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90"
    }
    modtm = {
      source  = "azure/modtm"
      version = "~> 0.3"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "25538273-e37b-4758-89b1-d352cdac750c"
}
