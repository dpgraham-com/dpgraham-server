variable "name" {
  type        = string
  description = "The name of the cloud run resource instance"
}

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

variable "port" {
  type        = string
  description = "The PORT cloud run will listen for"
}

variable "image" {
  type        = string
  description = "The container image, located on GCP artifact registry to use"
}

variable "vpc_connector" {
  type        = string
  description = "The ID of the VPC connector to use"
}

variable "max_count" {
  type        = number
  description = "The maximum number of instances to run"
  default     = 3
}

variable "env" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}
