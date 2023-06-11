resource "google_project_service" "iam_googleapis_com" {
  project = "26185934994"
  service = "iam.googleapis.com"
}
# terraform import google_project_service.iam_googleapis_com 26185934994/iam.googleapis.com
