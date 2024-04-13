resource "google_firebase_project" "default" {
  provider = google-beta
  project  = var.project_id
}

resource "google_project_service" "firebase_database" {
  provider = google-beta
  project  = google_firebase_project.default.project
  service  = "firebasedatabase.googleapis.com"
}

resource "google_firebase_database_instance" "default" {
  provider    = google-beta
  project     = google_firebase_project.default.project
  region      = "asia-southeast1"
  instance_id = "lgtmgen-project-default-rtdb"
  type        = "DEFAULT_DATABASE"
  depends_on  = [google_project_service.firebase_database]
}
