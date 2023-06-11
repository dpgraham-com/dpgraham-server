resource "google_project_service" "containerregistry_googleapis_com" {
  project = "26185934994"
  service = "containerregistry.googleapis.com"
}
# terraform import google_project_service.containerregistry_googleapis_com 26185934994/containerregistry.googleapis.com
