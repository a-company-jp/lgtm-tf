resource "google_cloud_run_service" "cloudrun-dev-main-backend" {
  name     = "dev-main-backend"
  location = var.region

  template {
    spec {
      containers {
        image = "asia-northeast1-docker.pkg.dev/${var.project_id}/dev-main/backend"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}
