terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.9.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.3"
    }
  }
  backend "azurerm" {}
  required_version = "~> 1.9.8"
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}