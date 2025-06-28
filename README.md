# 🚀 SimpleTimeService - DevOps Challenge Solution

Welcome! This repository contains the full solution to the Particle41 DevOps challenge, including a containerized application and infrastructure-as-code (IaC) setup using Terraform to deploy it on AWS ECS Fargate.

---

## 📌 Project Structure

```
.
├── app/                        # Flask microservice app
│   ├── main.py                # Python application
│   ├── Dockerfile             # Dockerfile with non-root setup
│   ├── requirements.txt       # Flask dependency
│   └── README.md              # App-specific documentation
├── terraform/                 # Infrastructure as Code (IaC)
│   ├── main.tf                # AWS VPC + ECS Fargate infra
│   ├── variables.tf           # Input variables
│   ├── outputs.tf             # Outputs (e.g., ALB DNS)
│   ├── terraform.tfvars       # Docker image input
│   ├── backend.tf             # S3 + DynamoDB backend config
│   └── README.md              # Deployment guide
└── .github/
    └── workflows/
        └── deploy.yml         # GitHub Actions CI/CD pipeline
```

---

## 🧠 Objective

- ✅ Build a minimal microservice returning current UTC time and client IP.
- ✅ Containerize it using Docker (non-root, minimal image).
- ✅ Push it to Docker Hub.
- ✅ Create a complete Terraform-based infrastructure on AWS using ECS Fargate.
- ✅ Automate deployments via GitHub Actions for `dev` and `prod`.
- ✅ Enable manual `destroy` capability via workflow dispatch.

---

## 🖥️ Application Details

**Language:** Python  
**Framework:** Flask  
**Port:** `5000`

### 🔁 JSON Response Format

```json
{
  "timestamp": "2025-06-24T22:45:12.123456Z",
  "ip": "172.17.0.1"
}
```

---

## 🐳 Docker Instructions

### ✅ Build

```bash
cd app
docker build -t simpletimeservice .
```

### ▶️ Run

```bash
docker run -p 5000:5000 simpletimeservice
```

### 🔐 Security

- ✅ Runs as a non-root user
- ✅ Uses `python:3.11-slim` for a minimal base image
- ✅ No unnecessary packages or bloat

---

## ☁️ Terraform Infrastructure (AWS ECS Fargate)

This Terraform setup deploys:

- VPC with:
  - 2 Public subnets
  - 2 Private subnets
- ECS Cluster
- Fargate Task Definition
- ECS Service (using your container image)
- Application Load Balancer (ALB)
- IAM roles and security groups
- Remote state storage in S3 + locking via DynamoDB

---

## 🗂️ Remote Backend Setup (Once)

```bash
aws s3api create-bucket --bucket p41-simpletime-tfstate --region us-east-1

aws dynamodb create-table   --table-name terraform-locks   --attribute-definitions AttributeName=LockID,AttributeType=S   --key-schema AttributeName=LockID,KeyType=HASH   --billing-mode PAY_PER_REQUEST   --region us-east-1
```

---

## 🚀 Deploy Instructions

### Prerequisites

- AWS credentials configured (`aws configure`)
- Terraform v1.6+
- Docker image pushed to Docker Hub

### Steps

```bash
cd terraform
terraform init
terraform plan -var="container_image=<your_dockerhub_username>/simpletimeservice:dev"
terraform apply -auto-approve -var="container_image=<your_dockerhub_username>/simpletimeservice:dev"
```

---

## 🌍 Access the App

```bash
terraform output alb_dns_name
```

Open in browser:

```bash
http://<alb_dns_name>/
```

---

## 🔁 CI/CD with GitHub Actions

Triggers:
- Auto deploy on push to `main` and `dev` branches
- Image tagged as `:prod` or `:dev`
- Terraform applied with environment-specific state
- Manual destroy via workflow dispatch

Secrets required in GitHub:
- `DOCKER_USER`, `DOCKER_PASS`
- `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`

---

## ✅ Evaluation Criteria Mapping

| Requirement                            | ✅ Status |
|----------------------------------------|-----------|
| Minimal app that returns IP and time   | ✅        |
| Dockerized with non-root user          | ✅        |
| Slim image without bloat               | ✅        |
| `docker build` works directly          | ✅        |
| `docker run` works and keeps running   | ✅        |
| Clear, complete documentation          | ✅        |
| ECS Fargate deployment via Terraform   | ✅        |
| Load Balancer on public subnet         | ✅        |
| Task running on private subnets        | ✅        |
| Remote Terraform state (S3 + DynamoDB) | ✅        |
| CI/CD pipeline included                | ✅        |

---

## 🧼 Cleanup

```bash
cd terraform
terraform destroy -auto-approve -var="container_image=dummy"
```

Or manually trigger the **"Destroy"** workflow in GitHub Actions.

---

## 📬 Final Notes

This solution follows container and Terraform best practices and is built with automation, security, and clarity in mind.  
Please feel free to clone, test, and deploy!

