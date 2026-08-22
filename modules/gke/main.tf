resource "google_container_cluster" "main" {
  name     = "${var.project_name}-cluster-${var.environment}"
  location = var.region
  project  = var.project_id

  # Remove node pool default — usamos node pools separados
  remove_default_node_pool = true
  initial_node_count       = 1

  # VPC nativa (alias IP) — obrigatório para muitos add-ons
  networking_mode = "VPC_NATIVE"
  network         = var.network_id
  subnetwork      = var.subnet_id

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  # Workload Identity: pods assumem service accounts do GCP sem chaves
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  # Logging e monitoramento nativos do GCP
  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
  }

  # Manutenção automática em horário de baixo tráfego
  maintenance_policy {
    recurring_window {
      start_time = "2024-01-01T03:00:00Z"
      end_time   = "2024-01-01T07:00:00Z"
      recurrence = "FREQ=WEEKLY;BYDAY=SA,SU"
    }
  }

  # Configurações de segurança
  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  release_channel {
    channel = var.release_channel
  }
}
