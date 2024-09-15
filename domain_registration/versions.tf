terraform {


  backend "azurerm" {
    key = "platform.azure.domainregistration.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.84.0"
    }
    databricks = {
      source = "databricks/databricks"
    }
  }

  required_version = ">= 1.2.3"

}

provider "azurerm" {
  features {}
}

provider "databricks" {
  host = "https://adb-71195058626629.9.azuredatabricks.net"
}

data "azurerm_client_config" "current" {}

data "databricks_current_user" "me" {}