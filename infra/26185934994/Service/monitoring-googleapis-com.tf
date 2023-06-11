resource "google_project_service" "monitoring_googleapis_com" {
  project = "26185934994"
  service = "monitoring.googleapis.com"
}
# terraform import google_project_service.monitoring_googleapis_com 26185934994/monitoring.googleapis.com
