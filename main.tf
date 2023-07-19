terraform {
  required_version = ">= 0.12"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.0"
    }
  }
}

provider "azurerm" {
  features {}
}
# import the random provider
provider "random" {}

# use the random provider to generate a random id
resource "random_id" "storage" {
  byte_length = 8
}

resource "azurerm_resource_group" "dev" {
  name     = "blobWebAppDev"
  location = "eastus"
}


