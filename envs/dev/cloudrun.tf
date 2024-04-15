resource "google_cloud_run_v2_service" "cloudrun-dev-main-backend" {
  name     = "dev-main-backend"
  location = var.region

  template {
    containers {
      name  = "nginx"
      image = "asia-northeast1-docker.pkg.dev/${var.project_id}/dev-main/nginx:latest"
      ports {
        container_port = 80
      }
      resources {
        limits = {
          "memory" = "1024Mi"
        }
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
  }

  traffic {
    revision = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent  = 100
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
  location = google_cloud_run_v2_service.cloudrun-dev-main-backend.location
  project  = google_cloud_run_v2_service.cloudrun-dev-main-backend.project
  service  = google_cloud_run_v2_service.cloudrun-dev-main-backend.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
