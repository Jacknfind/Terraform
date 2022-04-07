variable "tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

variable "public_enabled" {
  type        = bool
  default     = true
  description = "Whether to create public Route53 zone."
}

variable "domain_name" {
  type        = string
  default     = "naulproject"
  description = "This is the name of the resource."
}

variable "comment" {
  type        = string
  default     = ""
  description = "A comment for the hosted zone. Defaults to 'Managed by Terraform'."
}

variable "force_destroy" {
  type        = bool
  default     = true
  description = "Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone."
}

variable "reference_name" {
  type        = string
  default     = ""
  description = "The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc as delegation sets can only be used for public zones."
}

variable "policy_name" {
  type        = string
  default     = "route53-query-logging-policy"
  description = "The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc as delegation sets can only be used for public zones."
}