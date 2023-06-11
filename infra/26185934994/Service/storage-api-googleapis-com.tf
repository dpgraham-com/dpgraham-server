resource "google_project_service" "storage_api_googleapis_com" {
  project = "26185934994"
  service = "storage-api.googleapis.com"
}
# terraform import google_project_service.storage_api_googleapis_com 26185934994/storage-api.googleapis.com
