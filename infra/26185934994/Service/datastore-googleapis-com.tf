resource "google_project_service" "datastore_googleapis_com" {
  project = "26185934994"
  service = "datastore.googleapis.com"
}
# terraform import google_project_service.datastore_googleapis_com 26185934994/datastore.googleapis.com
