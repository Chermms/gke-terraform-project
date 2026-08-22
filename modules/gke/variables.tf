variable "project_id" {
  description = "ID do projeto GCP"
  type        = string
}

variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "environment" {
  description = "Ambiente (dev, prod)"
  type        = string
}

variable "region" {
  description = "Região GCP"
  type        = string
}

variable "network_id" {
  description = "ID da VPC"
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet"
  type        = string
}

variable "release_channel" {
  description = "Canal de release do GKE (RAPID, REGULAR, STABLE)"
  type        = string
  default     = "REGULAR"
}
