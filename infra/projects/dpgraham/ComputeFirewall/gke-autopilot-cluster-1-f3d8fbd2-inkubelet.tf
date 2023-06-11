resource "google_compute_firewall" "gke_autopilot_cluster_1_f3d8fbd2_inkubelet" {
  allow {
    ports    = ["10255"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  name          = "gke-autopilot-cluster-1-f3d8fbd2-inkubelet"
  network       = "https://www.googleapis.com/compute/v1/projects/dpgraham/global/networks/default"
  priority      = 999
  project       = "dpgraham"
  source_ranges = ["10.42.0.0/17"]
  source_tags   = ["gke-autopilot-cluster-1-f3d8fbd2-node"]
  target_tags   = ["gke-autopilot-cluster-1-f3d8fbd2-node"]
}
# terraform import google_compute_firewall.gke_autopilot_cluster_1_f3d8fbd2_inkubelet projects/dpgraham/global/firewalls/gke-autopilot-cluster-1-f3d8fbd2-inkubelet
