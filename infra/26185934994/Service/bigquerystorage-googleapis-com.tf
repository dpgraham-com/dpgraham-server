resource "google_project_service" "bigquerystorage_googleapis_com" {
  project = "26185934994"
  service = "bigquerystorage.googleapis.com"
}
# terraform import google_project_service.bigquerystorage_googleapis_com 26185934994/bigquerystorage.googleapis.com
