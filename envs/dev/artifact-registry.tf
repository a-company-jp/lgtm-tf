resource "google_artifact_registry_repository" "main-repo" {
  location      = "asia-northeast1"
  repository_id = "dev-main"
  description   = "main repo for dev"
  format        = "DOCKER"
}
