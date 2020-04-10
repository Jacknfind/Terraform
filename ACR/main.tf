provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "springAcr" {
  name     = "${var.prefix}"
  location = "${var.location}"
}

resource "azurerm_container_registry" "spring" {
  name                = "${var.prefix}registry"
  resource_group_name = "data.azurerm_resource_group.springAcr.name"
  location            = "data.azurerm_resource_group.springAcr.location"
  sku                 = "${sku}"
}