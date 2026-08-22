output "network_id" {
  description = "ID da VPC"
  value       = google_compute_network.vpc.id
}

output "subnet_id" {
  description = "ID da subnet"
  value       = google_compute_subnetwork.app_subnet.id
}

output "subnet_name" {
  description = "Nome da subnet"
  value       = google_compute_subnetwork.app_subnet.name
}
