variable "aws_region" {
  description = "The AWS region."
  default     = "us-east-1"
}

variable "docker_image" {
  description = "The Docker image location in ECR or any accessible Docker registry."
  type        = string
}

variable "ecr_repository_url" {
  description = "The repository URL of the ECR repo"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}
