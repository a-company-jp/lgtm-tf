resource "google_cloud_run_service" "cloudrun-dev-main-backend" {
  name     = "dev-main-backend"
  location = var.region

  template {
    spec {
      containers {
        name  = "nginx"
        image = "asia-northeast1-docker.pkg.dev/${var.project_id}/dev-main/nginx:latest"
        ports {
          container_port = 80
        }
      }


      containers {
        name  = "backend"
        image = "asia-northeast1-docker.pkg.dev/${var.project_id}/dev-main/backend:latest"
        env {
          name  = "PORT"
          value = "8080"
        }
      }

      containers {
        name  = "frontend"
        image = "asia-northeast1-docker.pkg.dev/${var.project_id}/dev-main/frontend:latest"
        env {
          name  = "PORT"
          value = "3000"
        }
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
