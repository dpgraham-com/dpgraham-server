variable "project" {
  default     = "dpgraham"
  type        = string
  description = "The project ID"
}

variable "region" {
  type        = string
  description = "The region to deploy to"
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
