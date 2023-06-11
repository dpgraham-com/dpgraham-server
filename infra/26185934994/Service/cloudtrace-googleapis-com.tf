resource "google_project_service" "cloudtrace_googleapis_com" {
  project = "26185934994"
  service = "cloudtrace.googleapis.com"
}
# terraform import google_project_service.cloudtrace_googleapis_com 26185934994/cloudtrace.googleapis.com
