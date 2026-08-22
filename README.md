# 🚀 GKE Infrastructure with Terraform

Provisionamento de infraestrutura no Google Cloud Platform usando Terraform, seguindo boas práticas de IaC, segurança e escalabilidade.

## 📐 Arquitetura

```
GCP Project
└── VPC (network nativa)
    ├── Subnet: app-subnet
    └── GKE Cluster (regional - alta disponibilidade)
        ├── Node Pool: app-nodes (auto-scaling)
        └── Node Pool: infra-nodes (Prometheus, ArgoCD)
```

## 🗂️ Estrutura do Projeto

```
gke-terraform-project/
├── modules/
│   ├── vpc/          # Módulo de rede
│   ├── gke/          # Módulo do cluster GKE
│   └── node-pool/    # Módulo de node pools
├── environments/
│   ├── dev/          # Ambiente de desenvolvimento
│   └── prod/         # Ambiente de produção
├── scripts/          # Scripts utilitários
└── README.md
```

## 🛠️ Tecnologias

- **Terraform** >= 1.5
- **Google Cloud Platform**
  - GKE (Google Kubernetes Engine)
  - VPC nativa
  - Cloud Storage (state remoto)
  - Workload Identity
- **Kubernetes** >= 1.27

## ✅ Pré-requisitos

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.5
- [gcloud CLI](https://cloud.google.com/sdk/docs/install) autenticado
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- Projeto GCP com billing habilitado

## 🚀 Como usar

### 1. Clone o repositório
```bash
git clone https://github.com/seu-usuario/gke-terraform-project.git
cd gke-terraform-project
```

### 2. Configure as variáveis
```bash
cp environments/dev/terraform.tfvars.example environments/dev/terraform.tfvars
# edite o arquivo com seus valores
```

### 3. Inicialize e aplique
```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

### 4. Configure o kubectl
```bash
gcloud container clusters get-credentials <cluster-name> \
  --region <region> \
  --project <project-id>
```

## 🔒 Boas Práticas Implementadas

- ✅ State remoto no Cloud Storage com lock
- ✅ Workload Identity habilitado
- ✅ VPC nativa (alias IP)
- ✅ Node pools separados por função
- ✅ Auto-scaling de nós e pods (HPA)
- ✅ Auto-repair e auto-upgrade habilitados
- ✅ Módulos reutilizáveis por ambiente
- ✅ Variáveis sensíveis via tfvars (nunca no repositório)

## 📊 Ambientes

| Ambiente | Região | Nodes (min/max) | Machine Type |
|----------|--------|-----------------|--------------|
| dev | us-central1 | 1 / 3 | e2-standard-2 |
| prod | us-central1 | 2 / 10 | e2-standard-4 |

## 👤 Autor

**Gabriel Chermont**  
Cloud & Platform Engineer  
[LinkedIn](https://linkedin.com/in/seu-perfil) · [GitHub](https://github.com/seu-usuario)
