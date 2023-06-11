resource "google_compute_firewall" "gke_autopilot_cluster_1_f3d8fbd2_vms" {
  allow {
    ports    = ["1-65535"]
    protocol = "tcp"
  }

  allow {
    ports    = ["1-65535"]
    protocol = "udp"
  }

  allow {
    protocol = "icmp"
  }

  direction     = "INGRESS"
  name          = "gke-autopilot-cluster-1-f3d8fbd2-vms"
  network       = "https://www.googleapis.com/compute/v1/projects/dpgraham/global/networks/default"
  priority      = 1000
  project       = "dpgraham"
  source_ranges = ["10.128.0.0/9"]
  target_tags   = ["gke-autopilot-cluster-1-f3d8fbd2-node"]
}
# terraform import google_compute_firewall.gke_autopilot_cluster_1_f3d8fbd2_vms projects/dpgraham/global/firewalls/gke-autopilot-cluster-1-f3d8fbd2-vms
