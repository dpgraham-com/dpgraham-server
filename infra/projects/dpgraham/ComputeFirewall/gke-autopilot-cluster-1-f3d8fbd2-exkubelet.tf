resource "google_compute_firewall" "gke_autopilot_cluster_1_f3d8fbd2_exkubelet" {
  deny {
    ports    = ["10255"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  name          = "gke-autopilot-cluster-1-f3d8fbd2-exkubelet"
  network       = "https://www.googleapis.com/compute/v1/projects/dpgraham/global/networks/default"
  priority      = 1000
  project       = "dpgraham"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["gke-autopilot-cluster-1-f3d8fbd2-node"]
}
# terraform import google_compute_firewall.gke_autopilot_cluster_1_f3d8fbd2_exkubelet projects/dpgraham/global/firewalls/gke-autopilot-cluster-1-f3d8fbd2-exkubelet
