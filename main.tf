# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.50.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  skip_provider_registration = true
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "${var.env_tag}-${var.service_name}-rg"
  location = "East US"
  tags = {
   "service" = var.service_name,
   "environment" = var.env_tag
 }
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "example" {
  name                = "${var.env_tag}-${var.service_name}-network"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
  tags = {
   "service" = var.service_name,
   "environment" = var.env_tag
 }
}