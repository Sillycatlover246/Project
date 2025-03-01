variable "project_id" {
  description = "GCP project ID"
  type        = string
  default     = "devproject-451919"
}

variable "region" {
  description = "Region for GKE (e.g., us-central1)"
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "devproject-cluster"
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 2
}

variable "node_machine_type" {
  description = "Machine type for each node"
  type        = string
  default     = "e2-medium"
}
