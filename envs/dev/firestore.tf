resource "google_project_service" "firestore_api" {
  service = "firestore.googleapis.com"
}

resource "google_firestore_database" "datastore_mode_database" {
  name        = "(default)"
  location_id = "asia-northeast1"
  type        = "FIRESTORE_NATIVE"
}
