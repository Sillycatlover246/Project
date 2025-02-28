resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = "us-central1-a"
  
  # These should match your existing cluster's configuration
  # Remove this if your existing cluster has a different configuration
  initial_node_count = 1
  remove_default_node_pool = true

  network    = "default"
  subnetwork = "default"
  
  # Important: This tells Terraform not to try changing the cluster on every run
  lifecycle {
    ignore_changes = [
      node_config,
      initial_node_count,
      node_pool,
    ]
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-node-pool"
  project    = var.project_id
  location   = "us-central1-a"
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count

  node_config {
    machine_type = var.node_machine_type
    disk_size_gb = 80
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  
  # This prevents Terraform from recreating the node pool on every run
  lifecycle {
    ignore_changes = [
      node_count,
      node_config,
    ]
  }
}