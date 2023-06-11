resource "google_project_service" "oslogin_googleapis_com" {
  project = "26185934994"
  service = "oslogin.googleapis.com"
}
# terraform import google_project_service.oslogin_googleapis_com 26185934994/oslogin.googleapis.com
