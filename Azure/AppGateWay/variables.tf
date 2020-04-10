variable "location" {
  description = "Azure Region where the gateway will be created"
  default     = "canadacentral"
}

variable "resource_group_name" {
  description = "Resource group that will contain the gateway"
  default     = "spring-infra-dev01-rg"
}

variable "virtual_network" {
  description = "Virtual network existed one"
  default     = "spring-infra-dev01-vnet"
}

variable "app_gw_subnet" {
  description = "Subnet where the gateway will create its NIC"
  default     = "app-gw-snet"
}


variable "name" {
  description = "Root name applied to all resources. A dynamic name will be generated if none is provided"
  default     = "mtodev01"
}

variable "enable_http2" {
  description = "Enable the HTTP/2 protocol"
  default     = true
}

variable "private_ip_address" {
  description = "The Private IP Address to use for the Application Gateway."
}

variable "frontend_ip_configuration_name" {
  description = "front end Ip configuratin name"
  default     = "frontend_ip_config"
}

variable "frontend_https_port_name" {
  description = "front end Ip configuratin name"
  default     = "https"
}

variable "frontend_http_port_name" {
  description = "front end Ip configuratin name"
  default     = "http"
}

variable "https_listener_name" {
  description = "front end Ip configuratin name"
  default     = "https-listener"
}

variable "http_listener_name" {
  description = "front end Ip configuratin name"
  default     = "http-listener"
}

variable "backend_address_pool_name" {
  description = "front end Ip configuratin name"
  default     = "server-pool"
}

variable "backend_http_settings_name" {
  description = "front end Ip configuratin name"
  default     = "http-settings"
}



variable "cookie_based_affinity" {
  description = "Specify Enabled or Disabled. Controls cookie-based session affinity to backend pool members"
  default     = "Disabled"
}

variable "backend_request_timeout" {
  description = "Number of seconds to wait for a backend pool member to respond"
  default     = 60
}

variable "enable_connection_draining" {
  description = "Enable connection draining to change members within a backend pool without disruption"
  default     = false
}

variable "connection_drain_timeout" {
  description = "Number of seconds to wait before for active connections to drain out of a removed backend pool member"
  default     = 300
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  default     = "dev01"
}