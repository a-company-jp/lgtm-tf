resource "google_storage_bucket" "public_image_bucket" {
  name     = "lgtm-public-image-bucket"
  location = "ASIA-NORTHEAST1"
  # https://cloud.google.com/storage/docs/locations
  force_destroy = false

  uniform_bucket_level_access = true

  cors {
    origin          = [""]
    method          = ["GET"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}

resource "google_storage_bucket_access_control" "public_image_bucket" {
  bucket = google_storage_bucket.public_image_bucket.name
  role   = "READER"
  entity = "allUsers"
}

resource "google_storage_bucket_iam_binding" "public_image_bucket_editor" {
  bucket = google_storage_bucket.public_image_bucket.name
  role   = "roles/storage.objectAdmin"

  members = [
    "group:dev-members@a.shion.pro"
  ]
}
