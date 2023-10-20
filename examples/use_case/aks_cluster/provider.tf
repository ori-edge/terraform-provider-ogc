terraform {
  required_providers {
    ogc = {
      version = "0.0.1"
      source  = "hashicorp.com/dev/ogc"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "ogc" {}

provider "azurerm" {
  features {}
}
