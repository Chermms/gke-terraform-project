terraform {
  required_version = ">= 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  backend "gcs" {
    bucket = "meu-projeto-tfstate"
    prefix = "dev/gke"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source = "../../modules/vpc"

  project_id    = var.project_id
  project_name  = var.project_name
  region        = var.region
  subnet_cidr   = "10.10.0.0/24"
  pods_cidr     = "10.11.0.0/16"
  services_cidr = "10.12.0.0/16"
}

module "gke" {
  source = "../../modules/gke"

  project_id      = var.project_id
  project_name    = var.project_name
  environment     = "dev"
  region          = var.region
  network_id      = module.vpc.network_id
  subnet_id       = module.vpc.subnet_id
  release_channel = "REGULAR"
}

module "app_node_pool" {
  source = "../../modules/node-pool"

  project_id   = var.project_id
  cluster_id   = module.gke.cluster_id
  region       = var.region
  environment  = "dev"
  pool_name    = "app"
  machine_type = "e2-standard-2"  # menor custo em dev
  min_nodes    = 1
  max_nodes    = 3
}
