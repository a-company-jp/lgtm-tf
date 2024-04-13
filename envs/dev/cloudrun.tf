resource "google_cloud_run_service" "cloudrun-dev-main-backend" {
  name     = "dev-main-backend"
  location = var.region

  template {
    spec {
      containers {
        image = "asia-northeast1-docker.pkg.dev/${var.project_id}/dev-main/backend:latest"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.cloudrun-dev-main-backend.location
  project  = google_cloud_run_service.cloudrun-dev-main-backend.project
  service  = google_cloud_run_service.cloudrun-dev-main-backend.name

  policy_data = data.google_iam_policy.noauth.policy_data
}