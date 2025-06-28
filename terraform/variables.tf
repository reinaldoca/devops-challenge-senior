variable "region" {
  default = "us-east-1"
}

variable "container_image" {
  description = "Docker image URL (ex: yourdockerhub/simpletimeservice:latest)"
  type        = string
}

variable "aws_region" {
  default = "us-east-1"
}
