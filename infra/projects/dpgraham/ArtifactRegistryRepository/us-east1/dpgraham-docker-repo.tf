resource "google_artifact_registry_repository" "dpgraham_docker_repo" {
  description   = "initial docker registry with gcloud"
  format        = "DOCKER"
  location      = "us-east1"
  project       = "dpgraham"
  repository_id = "dpgraham-docker-repo"
}
# terraform import google_artifact_registry_repository.dpgraham_docker_repo projects/dpgraham/locations/us-east1/repositories/dpgraham-docker-repo
