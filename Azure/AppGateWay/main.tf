provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "appgw" {
  name     = "${var.resource_group_name}"
}

data "azurerm_virtual_network" "appgw" {
  name     = "${var.virtual_network}"
  resource_group_name = data.azurerm_resource_group.appgw.name
}

data "azurerm_subnet" "appgw" {
  name                 = "${var.app_gw_subnet}"
  virtual_network_name = "${var.virtual_network}"
  resource_group_name  = data.azurerm_resource_group.appgw.name
}


resource "azurerm_public_ip" "appgwpip" {
  name                = "appgw-pip"
  resource_group_name = data.azurerm_resource_group.appgw.name
  location            = data.azurerm_resource_group.appgw.location
  sku                 = "Standard"
  allocation_method   = "Dynamic"
  
  tags = "${var.tags}"
}

# since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name      = "${azurerm_virtual_network}"-beap
  frontend_port_name             = "${azurerm_virtual_network}"-feport
  frontend_ip_configuration_name = "${azurerm_virtual_network}"-feip
  http_setting_name              = "${azurerm_virtual_network}"-be-htst
  listener_name                  = "${azurerm_virtual_network}"-httplstn
  request_routing_rule_name      = "${azurerm_virtual_network}"-rqrt
  redirect_configuration_name    = "${azurerm_virtual_network}"-rdrcfg
}

resource "azurerm_application_gateway" "network" {
  name                = "${var.name}appgw"
  resource_group_name = data.azurerm_resource_group.appgw.name
  location            = data.azurerm_resource_group.appgw.location
  enable_http2        = "${var.enable_http2}"

  sku {
    name     = "Standard_Small"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "app-gw-config"
    subnet_id = "${var.app-gw-subnet_id}"
  }
  
  frontend_ip_configuration {
    name                 = "${frontend_ip_configuration_name}-public"
    public_ip_address_id = "${azurerm_public_ip.appgwpip.id}"
	subnet_id            = "${var.app-gw-subnet_id}"
  }
  
  frontend_ip_configuration {
    name                          = "${frontend_ip_configuration_name}-private"
    private_ip_address_allocation = "Static"
    private_ip_address            = "${var.private_ip_address}"
    subnet_id                     = "${var.app-gw-subnet_id}"
  }

  frontend_port {
    name = "${frontend_https_port_name}"
    port = 443
  }

  frontend_port {
    name = "${frontend_http_port_name}"
    port = 80
  }

 
  http_listener {
    name                           = "${frontend_http_port_name}"
    frontend_ip_configuration_name = "${frontend_http_port_name}"
    frontend_port_name             = "${frontend_http_port_name}"
    protocol                       = "Http"
  }
  
  http_listener {
    name                           = "${frontend_https_port_name}"
    frontend_ip_configuration_name = "${frontend_https_port_name}"
    frontend_port_name             = "${frontend_https_port_name}"
    protocol                       = "Https"
  }

  backend_address_pool {
    name = "${var.backend_address_pool_name}"
  }

  backend_http_settings {
    name                  = "${var.backend_http_settings_name}"
    cookie_based_affinity = "${var.cookie_based_affinity}"
    port                  = 80
    protocol              = "Http"
    request_timeout       = "${var.backend_request_timeout}"
	
	connection_draining {
      enabled             = "${var.enable_connection_draining}"
      drain_timeout_sec   = "${var.connection_drain_timeout}"
    }
  }

  request_routing_rule {
    name                       = "https-routing"
    rule_type                  = "Basic"
    http_listener_name         = "${https_listener_name}"
    backend_address_pool_name  = "${var.backend_address_pool_name}"
    backend_http_settings_name = "${var.backend_http_settings_name}"
  }

  request_routing_rule {
    name                       = "http-routing"
    rule_type                  = "Basic"
    http_listener_name         = "${http_listener_name}"
    backend_address_pool_name  = "${var.backend_address_pool_name}"
    backend_http_settings_name = "${var.backend_http_settings_name}"
  }
  
  tags = "${var.tags}"
}