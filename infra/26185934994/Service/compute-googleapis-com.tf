resource "google_project_service" "compute_googleapis_com" {
  project = "26185934994"
  service = "compute.googleapis.com"
}
# terraform import google_project_service.compute_googleapis_com 26185934994/compute.googleapis.com
