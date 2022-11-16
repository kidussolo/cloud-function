variable "project" {
	default = "test-project-2022-368715"
}
variable "region" {
	default = "us-central1" 
}

variable "function_name" {
  default = "hello-world"
}
variable "function_entry_point" {
  default = "helloWorld"
}

variable "token" {
  description = "Github OAuth token"
}

variable "repo_name" {
  description = "Github repository name"
  default = "cloud-functions"
}

variable "webhook_event" {
  description = "Github webhook event"
  default = "issues"
}