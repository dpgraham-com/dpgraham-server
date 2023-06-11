resource "google_project_service" "logging_googleapis_com" {
  project = "26185934994"
  service = "logging.googleapis.com"
}
# terraform import google_project_service.logging_googleapis_com 26185934994/logging.googleapis.com
