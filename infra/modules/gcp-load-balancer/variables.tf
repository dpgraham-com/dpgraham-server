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

variable "name" {
  description = "Name of the load balancer"
  type        = string
}

variable "domain_name" {
  description = "The domain name to use for the load balancer"
  type        = string
  default     = "dpgraham.com"
}

variable "ssl" {
  description = "Whether to use SSL or not"
  type        = bool
  default     = true
}

variable "service_name" {
  description = "The name of the service to deploy"
  type        = string
}