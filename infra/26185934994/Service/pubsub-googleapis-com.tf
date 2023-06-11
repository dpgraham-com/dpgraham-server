resource "google_project_service" "pubsub_googleapis_com" {
  project = "26185934994"
  service = "pubsub.googleapis.com"
}
# terraform import google_project_service.pubsub_googleapis_com 26185934994/pubsub.googleapis.com
