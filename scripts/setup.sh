#!/bin/bash
# setup.sh — configura o ambiente local para usar o projeto

set -e

PROJECT_ID=$1
REGION=${2:-"us-central1"}
BUCKET_NAME="${PROJECT_ID}-tfstate"

echo "🚀 Configurando projeto GCP: $PROJECT_ID"

# Autentica no GCP
gcloud auth application-default login

# Define o projeto padrão
gcloud config set project $PROJECT_ID

# Cria o bucket para o state remoto do Terraform
echo "📦 Criando bucket para state remoto..."
gsutil mb -p $PROJECT_ID -l $REGION gs://$BUCKET_NAME || echo "Bucket já existe"

# Habilita versionamento no bucket (proteção extra)
gsutil versioning set on gs://$BUCKET_NAME

# Habilita as APIs necessárias
echo "🔧 Habilitando APIs GCP..."
gcloud services enable \
  container.googleapis.com \
  compute.googleapis.com \
  iam.googleapis.com \
  cloudresourcemanager.googleapis.com

echo "✅ Setup concluído! Atualize o bucket name nos backends e rode terraform init"
