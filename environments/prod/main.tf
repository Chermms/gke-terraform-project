terraform {
  required_version = ">= 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  # State remoto no Cloud Storage — nunca perde o estado
  backend "gcs" {
    bucket = "meu-projeto-tfstate"
    prefix = "prod/gke"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# ── VPC ────────────────────────────────────────────────
module "vpc" {
  source = "../../modules/vpc"

  project_id   = var.project_id
  project_name = var.project_name
  region       = var.region
  subnet_cidr  = "10.0.0.0/24"
  pods_cidr    = "10.1.0.0/16"
  services_cidr = "10.2.0.0/16"
}

# ── GKE Cluster ────────────────────────────────────────
module "gke" {
  source = "../../modules/gke"

  project_id   = var.project_id
  project_name = var.project_name
  environment  = "prod"
  region       = var.region
  network_id   = module.vpc.network_id
  subnet_id    = module.vpc.subnet_id
  release_channel = "STABLE"
}

# ── Node Pool: aplicações ──────────────────────────────
module "app_node_pool" {
  source = "../../modules/node-pool"

  project_id   = var.project_id
  cluster_id   = module.gke.cluster_id
  region       = var.region
  environment  = "prod"
  pool_name    = "app"
  machine_type = "e2-standard-4"  # 4 vCPU, 16 GB RAM
  min_nodes    = 2
  max_nodes    = 10
}

# ── Node Pool: infra (Prometheus, ArgoCD) ─────────────
module "infra_node_pool" {
  source = "../../modules/node-pool"

  project_id   = var.project_id
  cluster_id   = module.gke.cluster_id
  region       = var.region
  environment  = "prod"
  pool_name    = "infra"
  machine_type = "n2-standard-2"  # 2 vCPU, 8 GB RAM
  min_nodes    = 1
  max_nodes    = 3
}
