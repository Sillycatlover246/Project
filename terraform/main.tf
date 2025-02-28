resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = "us-central1-a"
  project  = "devproject-451919"  # Explicitly set project ID
  
  # Set these to match your existing cluster
  # If Terraform can't import, it might try to create/modify
  initial_node_count = 1
  remove_default_node_pool = true

  network    = "default"
  subnetwork = "default"
  
  # Critical: This prevents Terraform from trying to manage aspects 
  # of the cluster that might differ from your config
  lifecycle {
    ignore_changes = [
      initial_node_count,
      node_config,
      master_auth,
      ip_allocation_policy,
      enable_autopilot,
      node_pool,
      binary_authorization,
      remove_default_node_pool,
    ]
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-node-pool"
  project    = "devproject-451919"  # Explicitly set project ID
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
  
  # This prevents Terraform from modifying existing node pool config
  lifecycle {
    ignore_changes = [
      node_count,
      node_config,
      version,
      management,
      upgrade_settings,
    ]
  }
}