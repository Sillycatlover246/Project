output "cluster_name" {
  description = "Name of the cluster"
  value       = google_container_cluster.primary.name
}

output "kubeconfig" {
  description = "Endpoint of the cluster (to be used for generating kubeconfig)"
  value       = google_container_cluster.primary.endpoint
}
