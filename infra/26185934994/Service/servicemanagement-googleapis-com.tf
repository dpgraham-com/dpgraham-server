resource "google_project_service" "servicemanagement_googleapis_com" {
  project = "26185934994"
  service = "servicemanagement.googleapis.com"
}
# terraform import google_project_service.servicemanagement_googleapis_com 26185934994/servicemanagement.googleapis.com
