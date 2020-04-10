variable "prefix" {
  description = "The prefix used for all resources in this example"
  value       = "dmr-spring-infra-dev01-rg"
}

variable "location" {
  description = "The Azure location where all resources in this example should be created"
  value       = "Central Canada"
}

variable "sku" {
  description = "The ACR sku types basic, standard, premium"
  value       = "Basic"
  
}