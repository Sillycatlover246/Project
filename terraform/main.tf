resource "google_container_cluster" "primary" {
  name                      = var.cluster_name
  location                  = "us-central1-a"   # Use a specific zone
  initial_node_count        = 1
  remove_default_node_pool  = true
  network                   = "default"
  subnetwork                = "default"
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
    disk_type    = "pd-ssd"          # **Added disk_type attribute**
    image_type   = "COS_CONTAINERD"  # or "UBUNTU_CONTAINERD" if preferred
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
