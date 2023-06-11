resource "google_compute_target_pool" "a46e169c6865340cab9f0b4428fe7519" {
  description      = "{\"kubernetes.io/service-name\":\"default/dpg-server1-service\"}"
  health_checks    = ["https://www.googleapis.com/compute/beta/projects/dpgraham/global/httpHealthChecks/k8s-dece0de9e6ddd659-node"]
  instances        = ["us-east1-b/gk3-autopilot-cluster-1-default-pool-bd81cf24-c66v", "us-east1-b/gk3-autopilot-cluster-1-pool-1-2f3b2674-f422", "us-east1-c/gk3-autopilot-cluster-1-pool-1-84f1fa7a-vtwk", "us-east1-d/gk3-autopilot-cluster-1-default-pool-4ed39376-fk3w"]
  name             = "a46e169c6865340cab9f0b4428fe7519"
  project          = "dpgraham"
  region           = "us-east1"
  session_affinity = "NONE"
}
# terraform import google_compute_target_pool.a46e169c6865340cab9f0b4428fe7519 projects/dpgraham/regions/us-east1/targetPools/a46e169c6865340cab9f0b4428fe7519
