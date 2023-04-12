# Assumption is you will be using az cli authentication
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
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
variable "location" {
  type = string
}
variable "saname" {
  type = string
}

# Resources
resource "azurerm_resource_group" "ch01rg" {
  name     = "ch01rg"
  location = var.location
}

resource "azurerm_storage_account" "ch1sa" {
  name                     = var.saname
  resource_group_name      = azurerm_resource_group.ch01rg.name
  location                 = azurerm_resource_group.ch01rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Outputs
output "storageid" {
  value = azurerm_storage_account.ch1sa.id
}