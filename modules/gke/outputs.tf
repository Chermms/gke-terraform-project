output "cluster_id" {
  description = "ID do cluster GKE"
  value       = google_container_cluster.main.id
}

output "cluster_name" {
  description = "Nome do cluster GKE"
  value       = google_container_cluster.main.name
}

output "cluster_endpoint" {
  description = "Endpoint do cluster"
  value       = google_container_cluster.main.endpoint
  sensitive   = true
}
