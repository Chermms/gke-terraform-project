variable "project_id" {
  description = "ID do projeto GCP"
  type        = string
}

variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "meu-projeto"
}

variable "region" {
  description = "Região GCP"
  type        = string
  default     = "us-central1"
}
