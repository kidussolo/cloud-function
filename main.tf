provider "google" {
  project = var.project
  region  = var.region
}
locals {
  timestamp = formatdate("YYMMDDhhmmss", timestamp())
	source_dir = "${path.module}/cloud-function"
}

# Compress source code
data "archive_file" "source" {
  type        = "zip"
  source_dir  = local.source_dir
  output_path = "${path.module}/${local.timestamp}.zip"
}

resource "google_storage_bucket" "bucket" {
  name                        = "${var.project}-function"
  location                    = "US"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "object" {
  name   = "cloud-function.zip"
  bucket = google_storage_bucket.bucket.name
  source = data.archive_file.source.output_path
}

resource "google_cloudfunctions2_function" "function" {
  name        = var.function_name

  build_config {
    runtime     = "nodejs16"
    entry_point = var.function_entry_point
    source {
      storage_source {
        bucket = google_storage_bucket.bucket.name
        object = google_storage_bucket_object.object.name
      }
    }
  }

  service_config {
    max_instance_count = 1
    available_memory   = "256M"
    timeout_seconds    = 60
  }
}
