terraform {
  backend "gcs" {
    bucket = "dpgraham-terraform-state1"
    prefix = "terraform1"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project = "dpgraham"
  region  = "us-east1"
  zone    = "us-east1-b"
}


resource "google_compute_network" "vpc" {
  name = "dpgraham-vpc"
}
resource "google_project_service" "vpcaccess-api" {
  project = var.project
  service = "vpcaccess.googleapis.com"
}

resource "google_vpc_access_connector" "dpgraham-vpc-connector" {
  name          = "dpgraham-vpc-connector"
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.14.0.0/28"
}

resource "google_sql_database_instance" "dpgraham_postgres" {
  name             = "dpgraham-postgres"
  database_version = "POSTGRES_14"
  region           = var.region
  project          = var.project

  settings {
    tier              = "db-f1-micro"
    activation_policy = "ALWAYS"
    availability_type = "ZONAL"
    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
    }
  }
}

resource "google_sql_database" "dpgraham_sql" {
  name     = "dpgraham"
  instance = google_sql_database_instance.dpgraham_postgres.name
}

resource "google_sql_user" "users" {
  instance = google_sql_database_instance.dpgraham_postgres.name
  type     = "BUILT_IN"
  name     = var.db_username
  password = var.db_password
}

# Example apache server we'll use to test Cloud DNS
resource "google_compute_instance" "test_apache" {
  name         = "test-apache-instance"
  machine_type = "e2-micro"
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network = google_compute_network.vpc.name
    access_config {
      // Ephemeral public IP
    }
  }
  metadata_startup_script = <<-EOF
  sudo apt-get update && \
  sudo apt-get install apache2 -y && \
  echo "<!doctype html><html><body><h1>Hello World!</h1></body></html>" > /var/www/html/index.html
  EOF
}

# to allow http traffic
resource "google_compute_firewall" "dpgraham_http" {
  name    = "allow-http-traffic"
  network = google_compute_network.vpc.name
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }
  source_ranges = ["0.0.0.0/0"]
}

# to create a DNS zone
resource "google_dns_managed_zone" "dpgraham_com" {
  name          = "dpgraham-zone"
  dns_name      = "dpgraham.com."
  description   = "DNS zone following the google create-domain-tutorial"
  force_destroy = "true"
}

# to register web-server's ip address in DNS
resource "google_dns_record_set" "dpgraham_com_record_set" {
  name         = google_dns_managed_zone.dpgraham_com.dns_name
  managed_zone = google_dns_managed_zone.dpgraham_com.name
  type         = "A"
  ttl          = 300
  rrdatas = [
    google_compute_instance.test_apache.network_interface[0].access_config[0].nat_ip
  ]
}

# google compute managed ssl certificate
resource "google_compute_managed_ssl_certificate" "dpgraham_com" {
  project     = var.project
  provider    = google-beta
  description = "Google managed SSL certificate for dpgraham.com"
  name        = "dpgraham-ssl-cert"

  managed {
    domains = [var.domain_name]
  }
}

resource "google_artifact_registry_repository" "dpgraham_com" {
  location      = var.region
  repository_id = "dpgraham-com"
  description   = "Repository for dpgraham.com"
  format        = "DOCKER"
}


data "google_iam_policy" "noauth" {
  binding {
    role    = "roles/run.invoker"
    members = ["allUsers"]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_v2_service.server.location
  project  = google_cloud_run_v2_service.server.project
  service  = google_cloud_run_v2_service.server.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

resource "google_cloud_run_v2_service" "server" {
  name     = "dpgraham-api"
  location = var.region

  template {
    containers {
      image = format("%s-docker.pkg.dev/%s/%s/%s:latest", google_artifact_registry_repository.dpgraham_com.location, var.project, google_artifact_registry_repository.dpgraham_com.repository_id, var.server_image_name)
      env {
        name  = "DB_PORT"
        value = "5432"
      }
      env {
        name  = "DB_NAME"
        value = google_sql_database.dpgraham_sql.name
      }
      env {
        name  = "DB_USER"
        value = google_sql_user.users.name
      }
      env {
        name  = "DB_PASSWORD"
        value = google_sql_user.users.password
      }
      env {
        name  = "DB_HOST"
        value = var.db_host
      }
    }
    vpc_access {
      connector = google_vpc_access_connector.dpgraham-vpc-connector.id
      egress    = "ALL_TRAFFIC"
    }
    scaling {
      # Limit scale up to prevent any cost blow outs!
      max_instance_count = 3
    }
  }
}
