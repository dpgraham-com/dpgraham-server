resource "google_compute_http_health_check" "k8s_dece0de9e6ddd659_node" {
  check_interval_sec  = 8
  description         = "{\"kubernetes.io/service-name\":\"k8s-dece0de9e6ddd659-node\"}"
  healthy_threshold   = 1
  name                = "k8s-dece0de9e6ddd659-node"
  port                = 10256
  project             = "dpgraham"
  request_path        = "/healthz"
  timeout_sec         = 1
  unhealthy_threshold = 3
}
# terraform import google_compute_http_health_check.k8s_dece0de9e6ddd659_node projects/dpgraham/global/httpHealthChecks/k8s-dece0de9e6ddd659-node
