resource "google_cloud_run_v2_service" "default" {
  name     = var.name
  location = var.region

  template {
    containers {
      ports {
        container_port = var.port
      }
      image = var.image
    }
    vpc_access {
      connector = var.vpc_connector
      egress    = "ALL_TRAFFIC"
    }
    scaling {
      # Limit scale up to prevent any cost blow outs!
      max_instance_count = var.max_count
    }
  }
}
