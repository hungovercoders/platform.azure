terraform {


  backend "azurerm" {
    key = "platform.azure.domainpublication.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.54.0"
    }
    databricks = {
      source = "databricks/databricks"
    }
    azapi = {
      source = "Azure/azapi"
    }
  }

  required_version = ">= 1.2.3"

}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}