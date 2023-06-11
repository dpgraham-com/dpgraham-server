resource "google_project_service" "storage_googleapis_com" {
  project = "26185934994"
  service = "storage.googleapis.com"
}
# terraform import google_project_service.storage_googleapis_com 26185934994/storage.googleapis.com
