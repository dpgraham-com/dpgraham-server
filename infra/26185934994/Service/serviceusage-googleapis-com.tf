resource "google_project_service" "serviceusage_googleapis_com" {
  project = "26185934994"
  service = "serviceusage.googleapis.com"
}
# terraform import google_project_service.serviceusage_googleapis_com 26185934994/serviceusage.googleapis.com
