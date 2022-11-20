# Cloud-function

Requirements
- Install terraform
- Install gcloud and follow the initialization for your specific OS.
- Clone the repo

### Activate the Application Default Credentials
```
gcloud auth application-default login
```

- Create a 'terraform.auto.tfvars' file in the root directory.

- Generte a GitHub access token

Go to settings -> developer settings in the bottom -> Personal Access Token -> Tokens (classic) -> Generate New Token -> Generate New Token (classic)
Then tick the repo and delete_repo permissions -> Generate token. Then Copy the token, and add token=’github_access_token_value’ in the 'terraform.auto.tfvars' file.

## In the root directory initialize terraform
```
terraform init
```
Then create the resources with
```
terraform apply
```
When it prompts for an answer type ‘yes’

### Resources created by terraform
- A cloud function that is publicly accessible.
- A GitHub Repo
- A webhook for the created GitHub repo which is triggered on the ‘issues’ event(when a new issue is created, closed, or opened…)

### Testing
- Go to the repository created and go to issues and create a new issue
- When a new issue is created the GitHub webhook will call the cloud function and a ‘Hello world!’ message will be printed in the cloud functions logs.
