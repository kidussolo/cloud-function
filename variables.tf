variable "token" {
  description = "Github OAuth token"
  default = ""
}

variable "repo_name" {
  description = "Github repository name"
  default = "test"
}

variable "description" {
  description = "Github repository description"
  default = "test"
}

variable "webhook_url" {
  description = "Cloud function webhook url"
  default = "https://GCP_REGION-PROJECT_ID.cloudfunctions.net/hello_http"
}

variable "webhook_event" {
  description = "Github webhook event"
  default = "push"
}