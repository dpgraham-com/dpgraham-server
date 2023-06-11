resource "google_project_service" "container_googleapis_com" {
  project = "26185934994"
  service = "container.googleapis.com"
}
# terraform import google_project_service.container_googleapis_com 26185934994/container.googleapis.com
