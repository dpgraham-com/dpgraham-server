resource "google_compute_firewall" "k8s_dece0de9e6ddd659_node_http_hc" {
  allow {
    ports    = ["10256"]
    protocol = "tcp"
  }

  description        = "{\"kubernetes.io/cluster-id\":\"dece0de9e6ddd659\"}"
  destination_ranges = ["34.23.89.215"]
  direction          = "INGRESS"
  name               = "k8s-dece0de9e6ddd659-node-http-hc"
  network            = "https://www.googleapis.com/compute/v1/projects/dpgraham/global/networks/default"
  priority           = 1000
  project            = "dpgraham"
  source_ranges      = ["130.211.0.0/22", "209.85.152.0/22", "209.85.204.0/22", "35.191.0.0/16"]
  target_tags        = ["gke-autopilot-cluster-1-f3d8fbd2-node"]
}
# terraform import google_compute_firewall.k8s_dece0de9e6ddd659_node_http_hc projects/dpgraham/global/firewalls/k8s-dece0de9e6ddd659-node-http-hc
