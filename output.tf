output "function_uri" {
  value = google_cloudfunctions_function.function.https_trigger_url
}