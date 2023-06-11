resource "google_compute_firewall" "gke_autopilot_cluster_1_f3d8fbd2_all" {
  allow {
    protocol = "ah"
  }

  allow {
    protocol = "esp"
  }

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "sctp"
  }

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  direction     = "INGRESS"
  name          = "gke-autopilot-cluster-1-f3d8fbd2-all"
  network       = "https://www.googleapis.com/compute/v1/projects/dpgraham/global/networks/default"
  priority      = 1000
  project       = "dpgraham"
  source_ranges = ["10.42.0.0/17"]
  target_tags   = ["gke-autopilot-cluster-1-f3d8fbd2-node"]
}
# terraform import google_compute_firewall.gke_autopilot_cluster_1_f3d8fbd2_all projects/dpgraham/global/firewalls/gke-autopilot-cluster-1-f3d8fbd2-all
