provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "apim" {
  name     = "${var.prefix}"
}

resource "azurerm_api_management" "apim_service" {
  name                = "${var.prefix}-apim-service"
  location            = data.azurerm_resource_group.apim.name
  resource_group_name = data.azurerm_resource_group.apim.name
  publisher_name      = "MTO"
  publisher_email     = "Mohammed.WaseemShahpuri@ontario.ca"
  sku_name            = "Developer_1"
  tags = {
    Environment = "${var.tags}"
  }
  policy {
    xml_content = <<XML
    <policies>
      <inbound />
      <backend />
      <outbound />
      <on-error />
    </policies>
XML
  }
}