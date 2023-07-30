# A terraform module to create a Cloud SQL instance with a Postgres database and a user.

locals {
  database_tier = var.environment == "production" ? "db-custom-1-3840" : "db-f1-micro"
}

resource "google_sql_database_instance" "database_instance" {
  name             = "${var.name}-postgres"
  database_version = "POSTGRES_14"
  region           = var.region
  project          = var.project_id

  settings {
    tier              = local.database_tier
    activation_policy = "ALWAYS"
    availability_type = "ZONAL"
    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
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
