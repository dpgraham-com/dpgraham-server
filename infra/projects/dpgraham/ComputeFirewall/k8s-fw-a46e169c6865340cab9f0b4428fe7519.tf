resource "google_compute_firewall" "k8s_fw_a46e169c6865340cab9f0b4428fe7519" {
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }

  description        = "{\"kubernetes.io/service-name\":\"default/dpg-server1-service\", \"kubernetes.io/service-ip\":\"34.23.89.215\"}"
  destination_ranges = ["34.23.89.215"]
  direction          = "INGRESS"
  name               = "k8s-fw-a46e169c6865340cab9f0b4428fe7519"
  network            = "https://www.googleapis.com/compute/v1/projects/dpgraham/global/networks/default"
  priority           = 1000
  project            = "dpgraham"
  source_ranges      = ["0.0.0.0/0"]
  target_tags        = ["gke-autopilot-cluster-1-f3d8fbd2-node"]
}
# terraform import google_compute_firewall.k8s_fw_a46e169c6865340cab9f0b4428fe7519 projects/dpgraham/global/firewalls/k8s-fw-a46e169c6865340cab9f0b4428fe7519
