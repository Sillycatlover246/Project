terraform {
  backend "gcs" {
    bucket = "devproject-terraform-state"  
    prefix = "terraform/state"
  }
  required_version = ">= 1.3.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = "us-central1-a"  
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
  zone    = "us-central1-a"
}
