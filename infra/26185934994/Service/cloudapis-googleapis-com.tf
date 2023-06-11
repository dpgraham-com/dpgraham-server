resource "google_project_service" "cloudapis_googleapis_com" {
  project = "26185934994"
  service = "cloudapis.googleapis.com"
}
# terraform import google_project_service.cloudapis_googleapis_com 26185934994/cloudapis.googleapis.com
