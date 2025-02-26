variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "Region for GKE (e.g., us-central1)"
  default     = "us-central1"
}

variable "gcp_credentials_file" {
  type        = string
  description = "Path to the GCP service account JSON key"
  default     = "gcp.json"
}


variable "cluster_name" {
  type        = string
  default     = "devproject-cluster"
  description = "Name of the GKE cluster"
}

variable "node_count" {
  type        = number
  default     = 2
  description = "Number of nodes in the default node pool"
}

variable "node_machine_type" {
  type        = string
  default     = "e2-medium"
  description = "Machine type for each node"
}
