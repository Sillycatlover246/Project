terraform {
  required_version = ">= 1.3.0"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 4.0"
    }
    googlebeta = {
      source = "hashicorp/googlebeta"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  credentials = file(var.gcp_credentials_file)
}

provider "googlebeta" {
  project = var.project_id
  region  = var.region
  credentials = file(var.gcp_credentials_file)
}
