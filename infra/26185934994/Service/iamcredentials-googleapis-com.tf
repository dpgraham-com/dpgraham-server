resource "google_project_service" "iamcredentials_googleapis_com" {
  project = "26185934994"
  service = "iamcredentials.googleapis.com"
}
# terraform import google_project_service.iamcredentials_googleapis_com 26185934994/iamcredentials.googleapis.com
