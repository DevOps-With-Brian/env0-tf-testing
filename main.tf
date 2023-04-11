# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.50.0"
    }
    doppler = {
      source = "DopplerHQ/doppler"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  skip_provider_registration = true
}

# Configure the Doppler provider with the token
provider "doppler" {
  doppler_token = var.doppler_token
}

# Define our data source to fetch secrets
data "doppler_secrets" "this" {}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "${data.doppler_secrets.this.map.ENV_TAG}-${data.doppler_secrets.this.map.SERVICE_NAME}-rg"
  location = data.doppler_secrets.this.map.AZ_LOCATION
  tags = {
   "service" = nonsensitive(data.doppler_secrets.this.map.SERVICE_NAME),
   "environment" = nonsensitive(data.doppler_secrets.this.map.ENV_TAG)
 }
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "example" {
  name                = "${data.doppler_secrets.this.map.ENV_TAG}-${data.doppler_secrets.this.map.SERVICE_NAME}-network"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
  tags = {
   "service" = nonsensitive(data.doppler_secrets.this.map.SERVICE_NAME),
   "environment" = nonsensitive(data.doppler_secrets.this.map.ENV_TAG)
 }
}