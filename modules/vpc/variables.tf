variable "project_id" {
  description = "ID do projeto GCP"
  type        = string
}

variable "project_name" {
  description = "Nome do projeto (usado como prefixo nos recursos)"
  type        = string
}

variable "region" {
  description = "Região GCP"
  type        = string
  default     = "us-central1"
}

variable "subnet_cidr" {
  description = "CIDR da subnet principal"
  type        = string
  default     = "10.0.0.0/24"
}

variable "pods_cidr" {
  description = "CIDR secundário para pods"
  type        = string
  default     = "10.1.0.0/16"
}

variable "services_cidr" {
  description = "CIDR secundário para services"
  type        = string
  default     = "10.2.0.0/16"
}
