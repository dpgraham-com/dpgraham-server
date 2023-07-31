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
      private_network    = var.vpc_id
      ipv4_enabled       = true
      allocated_ip_range = var.ip_range_name
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
