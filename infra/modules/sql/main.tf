# A terraform module to create a Cloud SQL instance with a Postgres database and a user.

locals {
  database_tier = var.environment == "production" ? "db-custom-1-3840" : "db-f1-micro"
  disk_size     = var.environment == "production" ? 10 : 10
  availability  = var.environment == "production" ? "REGIONAL" : "ZONAL"
}

resource "google_sql_database_instance" "database_instance" {
  name             = "${var.name}-postgres-test"
  database_version = "POSTGRES_14"
  region           = var.region
  project          = var.project_id
  depends_on       = [
    google_service_networking_connection.sql_vpc_connection
  ]

  settings {
    tier              = local.database_tier
    activation_policy = "ALWAYS"
    availability_type = local.availability
    disk_size         = local.disk_size
    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
    }
    ip_configuration {
      private_network    = var.vpc
      ipv4_enabled       = true
      allocated_ip_range = google_compute_global_address.private_ip_range.name
    }
  }
}

resource "google_sql_database" "postgres" {
  name     = var.name
  instance = google_sql_database_instance.database_instance.name
}

resource "google_sql_user" "user" {
  instance = google_sql_database_instance.database_instance.name
  type     = "BUILT_IN"
  name     = var.db_username
  password = var.db_password
}

resource "google_compute_global_address" "private_ip_range" {
  name          = "${var.name}-ip-range" # must be set to this for some reason "${vpc_name}-ip-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.vpc
}

resource "google_service_networking_connection" "sql_vpc_connection" {
  network                 = var.vpc
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.private_ip_range.name
  ]
}
