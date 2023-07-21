resource "google_compute_global_address" "dpgraham_com_static_ip" {
  address_type = "EXTERNAL"
  description  = "testing for creating a reserved static IP for dpgraham.com"
  ip_version   = "IPV4"
  name         = var.static_ip_name
  project      = var.project_id
}