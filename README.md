# DevOps Project: Flask Application Lifecycle Automation
This project implements a comprehensive DevOps pipeline for a Flask application that includes:

Containerization: Building, testing and publishing Docker images to a docker registry

Infrastructure as Code: Setting up and managing Google Cloud Platform resources using Terraform with remote state storage

Kubernetes Deployment: Configuring and deploying to GKE clusters using Helm charts

CI/CD Automation: Orchestrating the entire build, test, and deployment workflow

## CI/CD Pipeline Documentation
Our pipeline automates the entire application lifecycle:

**Build & Test Phase:**

Checks out the code from GitHub,
Sets up Python environment and installs dependencies,
Runs unit tests to verify code functionality,
Authenticates with DockerHub using secure credentials,
Builds Docker image with versioned tag and 'latest' tag,
Pushes images to DockerHub repository,
Runs integration tests against the container.


**Infrastructure Deployment:**

Sets up Terraform environment,
Initializes Terraform configuration and backend,
Imports existing resources if they exist,
Plans infrastructure changes,
Applies infrastructure changes to GCP.


**Application Deployment:**

Sets up Helm for Kubernetes deployments,
Authenticates with Google Cloud,
Gets credentials for the GKE cluster,
Deploys the application using Helm,
Waits for and displays the external IP,
Verifies deployment with integration test.