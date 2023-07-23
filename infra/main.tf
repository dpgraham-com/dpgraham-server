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
  project = "dpgraham"
  region  = "us-east1"
  zone    = "us-east1-b"
}


resource "google_compute_network" "vpc" {
  name = "dpgraham-vpc"
}
resource "google_project_service" "vpcaccess-api" {
  project = var.project
  service = "vpcaccess.googleapis.com"
}

resource "google_vpc_access_connector" "dpgraham-vpc-connector" {
  name          = "dpgraham-vpc-connector"
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.14.0.0/28"
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
    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
    }
  }
}

resource "google_sql_database" "dpgraham_sql" {
  name     = "dpgraham"
  instance = google_sql_database_instance.dpgraham_postgres.name
}

resource "google_sql_user" "users" {
  instance = google_sql_database_instance.dpgraham_postgres.name
  type     = "BUILT_IN"
  name     = var.db_username
  password = var.db_password
}

module "load_balancer" {
  source           = "./modules/gcp-load-balancer"
  name             = "dpgraham-frontend"
  backend_service  = module.server-service.name
  frontend_service = module.frontend-service.name
}

# The domain modules is used to provision resources, such as DNS zones and record sets for our domain
module "domain" {
  source       = "./modules/domain"
  project_id   = var.project
  domain_name  = var.domain_name
  ipv4_address = module.load_balancer.ip_address
}

resource "google_artifact_registry_repository" "dpgraham_com" {
  location      = var.region
  repository_id = "dpgraham-com"
  description   = "Repository for dpgraham.com"
  format        = "DOCKER"
}

module "frontend-service" {
  source        = "./modules/cloud-run"
  name          = "dpgraham-frontend"
  image         = format("%s-docker.pkg.dev/%s/%s/%s:latest", google_artifact_registry_repository.dpgraham_com.location, var.project, google_artifact_registry_repository.dpgraham_com.repository_id, var.client_image_name)
  vpc_connector = google_vpc_access_connector.dpgraham-vpc-connector.id
  port          = "3000"
}
module "server-service" {
  source        = "./modules/cloud-run"
  name          = "dpgraham-server"
  image         = format("%s-docker.pkg.dev/%s/%s/%s:latest", google_artifact_registry_repository.dpgraham_com.location, var.project, google_artifact_registry_repository.dpgraham_com.repository_id, var.server_image_name)
  vpc_connector = google_vpc_access_connector.dpgraham-vpc-connector.id
  port          = "8080"
  env = [
    {
      name  = "DB_PORT"
      value = "5432"
    },
    {
      name  = "DB_NAME"
      value = google_sql_database.dpgraham_sql.name
    },
    {
      name  = "DB_USER"
      value = google_sql_user.users.name
    },
    {
      name  = "DB_PASSWORD"
      value = google_sql_user.users.password
    },
    {
      name  = "DB_HOST"
      value = var.db_host
    }
  ]
}
