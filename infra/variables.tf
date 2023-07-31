variable "project" {
  description = "The project ID"
  type        = string
  default     = "dpgraham"
}

variable "domain_name" {
  description = "the top level domain of the project"
  type        = string
  default     = "dpgraham.com"
}

variable "region" {
  description = "The region to deploy to"
  type        = string
  default     = "us-east1"
}

variable "db_username" {
  description = "Database administrator username"
  type        = string
  default     = "root" // POC for now
}

variable "db_password" {
  description = "Database administrator password"
  default     = "password123" // POC for now
  type        = string
  sensitive   = true
}

variable "db_host" {
  description = "Database host ip address"
  default     = "10.14.144.3" // POC for now
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "dpgraham"
}

variable "server_image_name" {
  description = "The name of the image to use for the server"
  type        = string
  default     = "dpgraham-server"
}

variable "client_image_name" {
  description = "The name of the image to use for the client"
  type        = string
  default     = "dpgraham-client"
}
