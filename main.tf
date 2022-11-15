resource "github_repository" "repo" {
  name         = var.repo_name
  description  = var.description

  visibility = "public"
}

resource "github_repository_webhook" "webhook" {
  repository = github_repository.repo.name

  configuration {
    url          = var.webhook_url
    content_type = "json"
    insecure_ssl = false
  }

  active = false

  events = [var.webhook_event]
}
