resource "google_project_service" "dns_googleapis_com" {
  project = "26185934994"
  service = "dns.googleapis.com"
}
# terraform import google_project_service.dns_googleapis_com 26185934994/dns.googleapis.com
