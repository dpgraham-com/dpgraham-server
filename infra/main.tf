terraform {
  backend "gcs" {
    bucket  = "dpgraham-terraform-state1"
    prefix  = "terraform1"
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
  project = "dpgraham"
  region  = "us-east1"
  zone    = "us-east1-b"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_sql_database_instance" "dpgraham_postgres" {
  name             = "dpgraham-postgres"
  database_version = "POSTGRES_14"
  region           = "us-east1"
  project          = "dpgraham"

  settings {
    tier                 = "db-f1-micro"
    activation_policy    = "ALWAYS"
    availability_type    = "ZONAL"
  }
}

resource "google_sql_database" "dpgraham_database" {
  name     = "dpgraham-database"
  instance = google_sql_database_instance.dpgraham_postgres.name
}