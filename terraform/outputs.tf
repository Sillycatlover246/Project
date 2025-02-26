output "kubeconfig" {
  description = "Kubeconfig file for the created cluster"
  value       = google_container_cluster.primary.endpoint
}

output "cluster_name" {
  description = "Name of the cluster"
  value       = google_container_cluster.primary.name
}
