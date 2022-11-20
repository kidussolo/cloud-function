variable "project" {
  default = "cloud-function-test-369118"
}
variable "region" {
  default = "northamerica-northeast1"
}

variable "function_name" {
  default = "hello-world"
}
variable "function_entry_point" {
  default = "helloWorld"
}

variable "cloud_function_region" {
  default = "northamerica-northeast1"
}

variable "token" {
  description = "Github OAuth token"
}

variable "repo_name" {
  description = "Github repository name"
  default     = "Test-SC-API"
}

variable "webhook_event" {
  description = "Github webhook event"
  default     = "issues"
}

variable "bucket_name" {
  default = "sc-bucket-1"
}

variable "bucket_region" {
  default = "northamerica-northeast1"
}



