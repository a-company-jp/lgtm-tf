resource "google_storage_bucket" "public_image_bucket" {
  name     = "lgtm-public-image-bucket"
  location = "ASIA-NORTHEAST1"
  # https://cloud.google.com/storage/docs/locations
  force_destroy = false

  uniform_bucket_level_access = true

  cors {
    origin          = ["https://github.com"]
    method          = ["GET"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}