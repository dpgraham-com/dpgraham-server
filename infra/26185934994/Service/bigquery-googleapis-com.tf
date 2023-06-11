resource "google_project_service" "bigquery_googleapis_com" {
  project = "26185934994"
  service = "bigquery.googleapis.com"
}
# terraform import google_project_service.bigquery_googleapis_com 26185934994/bigquery.googleapis.com
