terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.108.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.2"
    }
  }
  backend "azurerm" {}
  required_version = ">=1.8.5"
}

provider "azurerm" {
  features {}
}