resource "google_container_cluster" "primary" {
  name                      = var.cluster_name
  location                  = "us-central1-a"   
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
    disk_size_gb = 80     #
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
