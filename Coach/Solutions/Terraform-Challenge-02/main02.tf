# Assumption is you will be using az cli authentication
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate-lnc01"
    storage_account_name = "tfstatelnc01"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}


# Variables
variable "rgname" {
  type = string
}
variable "location" {
  type = string
}
variable "saname" {
  type = string
}

variable "geoRedundancy" {
  type    = bool
  default = false
}

variable "containername" {
  type    = string
  default = "mycontainer"
}

