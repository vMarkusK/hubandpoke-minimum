terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
  }
  backend "azurerm" {}
  required_version = "~> 1.9.0"
}

provider "azurerm" {
  features {}
}