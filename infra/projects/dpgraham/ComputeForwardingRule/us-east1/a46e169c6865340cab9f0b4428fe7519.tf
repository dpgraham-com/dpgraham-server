resource "google_compute_forwarding_rule" "a46e169c6865340cab9f0b4428fe7519" {
  description           = "{\"kubernetes.io/service-name\":\"default/dpg-server1-service\"}"
  ip_address            = "34.23.89.215"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "a46e169c6865340cab9f0b4428fe7519"
  network_tier          = "PREMIUM"
  port_range            = "80-80"
  project               = "dpgraham"
  region                = "us-east1"
  target                = "https://www.googleapis.com/compute/beta/projects/dpgraham/regions/us-east1/targetPools/a46e169c6865340cab9f0b4428fe7519"
}
# terraform import google_compute_forwarding_rule.a46e169c6865340cab9f0b4428fe7519 projects/dpgraham/regions/us-east1/forwardingRules/a46e169c6865340cab9f0b4428fe7519
