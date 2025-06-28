# Terraform AWS Infrastructure for SimpleTimeService

This Terraform module provisions the required AWS infrastructure to host the SimpleTimeService container using ECS Fargate and an Application Load Balancer (ALB).

---

## 🔧 Prerequisites

- **Terraform installed**: https://developer.hashicorp.com/terraform/install
- **AWS CLI installed** and configured (`aws configure`)
- A Docker image of the application published to a container registry (e.g., DockerHub)

---

## 📦 Remote Terraform Backend

This project uses a remote backend in AWS S3 with DynamoDB for state locking.

### 💡 S3 Bucket and DynamoDB Table Setup (Run once)

```bash
aws s3api create-bucket --bucket p41-simpletime-tfstate --region us-east-1

aws dynamodb create-table \
  --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region us-east-1


## 🚀 Deployment

```bash
cd terraform
terraform init
terraform apply
