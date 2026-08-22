resource "google_container_node_pool" "main" {
  name     = "${var.pool_name}-pool"
  cluster  = var.cluster_id
  location = var.region
  project  = var.project_id

  # Auto-scaling: escala entre min e max nós por zona
  autoscaling {
    min_node_count = var.min_nodes
    max_node_count = var.max_nodes
  }

  node_config {
    machine_type = var.machine_type
    disk_size_gb = var.disk_size_gb
    disk_type    = "pd-ssd"

    # Habilita Workload Identity no nó
    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    # Labels para identificar o node pool
    labels = {
      environment = var.environment
      pool        = var.pool_name
    }

    # Taints para isolar workloads (opcional)
    dynamic "taint" {
      for_each = var.taints
      content {
        key    = taint.value.key
        value  = taint.value.value
        effect = taint.value.effect
      }
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  # Atualizações e reparos automáticos sem downtime
  management {
    auto_repair  = true
    auto_upgrade = true
  }

  # Estratégia de upgrade dos nós
  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0  # zero-downtime
  }
}
