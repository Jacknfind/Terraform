variable "tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

# Module      : Route53
# Description : Terraform Route53 module variables.
variable "private_enabled" {
  type        = bool
  default     = true
  description = "Whether to create private Route53 zone."
}

variable "domain_name" {
  type        = string
  default     = "naulprojectprivate"
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