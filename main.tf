terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.18.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.3"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.1.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.12.1"
    }
  }
  backend "azurerm" {}
  required_version = "~> 1.10.2"
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}