variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
  default     = "dpgraham"
}

variable "static_ip_name" {
  description = "the name applied to the static IP resource"
  type        = string
  default     = "dpgraham-com-global-ip"
}