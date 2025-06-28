terraform {
  backend "s3" {
    bucket         = "p41-simpletime-tfstate"
    key            = "ecs/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
