# The domain modules sets up a our Domain name and resources related
# to DNS, sub-domains, and the like... (todo update module docs LOL)

resource "google_compute_managed_ssl_certificate" "dpgraham_com" {
  project     = var.project_id
  provider    = google-beta
  description = "Google managed SSL certificate for dpgraham.com"
  name        = "dpgraham-ssl-cert"

  managed {
    domains = [var.domain_name]
  }
}

# Create a DNS managed zone
resource "google_dns_managed_zone" "dpgraham_com" {
  name          = var.dns_zone_name
  dns_name      = format("%s%s", var.domain_name, ".")
  description   = "DNS top level namespace"
  force_destroy = "true"
}
