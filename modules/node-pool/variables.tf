variable "project_id" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "region" {
  type = string
}

variable "environment" {
  type = string
}

variable "pool_name" {
  description = "Nome do node pool (ex: app, infra)"
  type        = string
}

variable "machine_type" {
  description = "Tipo de máquina GCP"
  type        = string
  default     = "e2-standard-4"
}

variable "disk_size_gb" {
  description = "Tamanho do disco em GB"
  type        = number
  default     = 100
}

variable "min_nodes" {
  description = "Número mínimo de nós por zona"
  type        = number
  default     = 1
}

variable "max_nodes" {
  description = "Número máximo de nós por zona"
  type        = number
  default     = 5
}

variable "taints" {
  description = "Taints aplicados aos nós"
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  default = []
}
