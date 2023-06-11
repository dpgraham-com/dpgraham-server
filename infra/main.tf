terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("dpgraham-56a7b1b3d974.json")
  project = "dpgraham"
  region  = "us-east1"
  zone    = "us-east1-b"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}