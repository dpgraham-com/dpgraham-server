variable "region" {
  default     = "us-east-1"
  type        = string
  description = "The region to deploy to"
}

variable "project_id" {
  default     = "dpgraham"
  type        = string
  description = "The project id to deploy to"
}

variable "name" {
  default     = "dpgraham"
  type        = string
  description = "The name to deploy to"
}

variable "db_username" {
  sensitive   = true
  type        = string
  description = "The database username"
}

variable "db_password" {
  sensitive   = true
  type        = string
  description = "The database password"
}

variable "environment" {
  type        = string
  description = "The environment to deploy to"
  validation {
    condition     = contains(["development", "production"], var.environment)
    error_message = "Environment must be one of [dev, prod]"
  }
}
