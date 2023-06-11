resource "google_project_service" "autoscaling_googleapis_com" {
  project = "26185934994"
  service = "autoscaling.googleapis.com"
}
# terraform import google_project_service.autoscaling_googleapis_com 26185934994/autoscaling.googleapis.com
