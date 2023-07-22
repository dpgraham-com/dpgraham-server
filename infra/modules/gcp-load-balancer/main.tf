resource "google_compute_global_address" "dpgraham_com_static_ip" {
  address_type = "EXTERNAL"
  description  = "testing for creating a reserved static IP for dpgraham.com"
  ip_version   = "IPV4"
  name         = var.static_ip_name
  project      = var.project_id
}

resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  provider              = google-beta
  name                  = "serverless-neg"
  network_endpoint_type = "SERVERLESS"
  region                = "us-east1"
  project               = var.project_id
  cloud_run {
    service = var.service_name
  }
}

module "lb-http" {
  source                          = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version                         = "~> 9.0"
  name                            = var.name
  project                         = var.project_id
  ssl                             = var.ssl
  managed_ssl_certificate_domains = [var.domain_name]
  https_redirect                  = var.ssl
  labels                          = { "example-label" = "cloud-run-example" }
  load_balancing_scheme           = "EXTERNAL_MANAGED"

  backends = {
    default = {
      description = null
      groups      = [
        {
          group = google_compute_region_network_endpoint_group.serverless_neg.id
        }
      ]
      enable_cdn = false

      iap_config = {
        enable = false
      }
      log_config = {
        enable = false
      }
    }
  }
}
