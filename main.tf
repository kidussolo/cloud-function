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

# Create a bucket to store the compressed zip file
resource "google_storage_bucket" "bucket" {
  name                        = "${var.project}-function"
  location                    = "US"
  uniform_bucket_level_access = true
}

# Add the object to the bucket
resource "google_storage_bucket_object" "object" {
  name   = "cloud-function.zip"
  bucket = google_storage_bucket.bucket.name
  source = data.archive_file.source.output_path
}

# Enable Cloud Functions API
resource "google_project_service" "cf" {
  project = var.project
  service = "cloudfunctions.googleapis.com"

  disable_dependent_services = true
  disable_on_destroy         = false
}

# Enable Cloud Build API
resource "google_project_service" "cb" {
  project = var.project
  service = "cloudbuild.googleapis.com"

  disable_dependent_services = true
  disable_on_destroy         = false
}

# Enable Cloud Run API
resource "google_project_service" "cr" {
  project = var.project
  service = "run.googleapis.com"

  disable_dependent_services = true
  disable_on_destroy         = false
}

# Enable Cloud Run API
resource "google_project_service" "ar" {
  project = var.project
  service = "artifactregistry.googleapis.com"

  disable_dependent_services = true
  disable_on_destroy         = false
}

# Create a cloud function
resource "google_cloudfunctions_function" "function" {
  name                  = var.function_name
  runtime               = "nodejs16"
  available_memory_mb   = 256
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.object.name
  entry_point           = var.function_entry_point

  trigger_http = true
}

# IAM entry so all users can invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

# Create a public GitHub Repo
resource "github_repository" "repo" {
  name         = var.repo_name
  visibility = "public"
  has_issues = true
  auto_init = true
}

# Add a Webhook to the repo for the event provided (Issues event)
# And set the url to the cloud function url
resource "github_repository_webhook" "webhook" {
  repository = github_repository.repo.name

  configuration {
    url          = google_cloudfunctions_function.function.https_trigger_url
    content_type = "json"
    insecure_ssl = false
  }

  active = true

  events = [var.webhook_event]
}