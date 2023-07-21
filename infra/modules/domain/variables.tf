variable "project_id" {
  type        = string
  description = "The project identifier"
}

variable "domain_name" {
  description = "the top level domain of the project"
  type        = string
  default     = "dpgraham.com"
}

variable "dns_zone_name" {
  description = "The Name given to our DNS managed zone"
  type        = string
  default     = "dpgraham-dns-zone"
}
