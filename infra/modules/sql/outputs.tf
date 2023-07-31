# outputs for the cloud sql instance and related resources

output "database_name" {
  value = google_sql_database.postgres.name
}

output "database_user" {
  value     = google_sql_user.user.name
  sensitive = true
}

output "database_password" {
  value     = google_sql_user.user.password
  sensitive = true
}

output "database_host" {
  value = google_sql_database_instance.database_instance.private_ip_address
}