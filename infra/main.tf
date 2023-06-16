terraform {
  backend "gcs" {
    bucket = "dpgraham-terraform-state1"
    prefix = "terraform1"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("terraform-key.json")
  project     = "dpgraham"
  region      = "us-east1"
  zone        = "us-east1-b"
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

variable "db_username" {
  description = "Database administrator username"
  type        = string
  default     = "root" // POC for now
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_sql_database_instance" "dpgraham_postgres" {
  name             = "dpgraham-postgres"
  database_version = "POSTGRES_14"
  region           = var.region
  project          = var.project

  settings {
    tier              = "db-f1-micro"
    activation_policy = "ALWAYS"
    availability_type = "ZONAL"
  }
}

resource "google_sql_database" "dpgraham_database" {
  name     = "dpgraham-database"
  instance = google_sql_database_instance.dpgraham_postgres.name
}

resource "google_sql_user" "users" {
  instance = google_sql_database_instance.dpgraham_postgres.name
  name     = var.db_username
  type     = "CLOUD_IAM_USER"
}