variable "aws_region" {
  description = "The AWS region."
  default     = "us-east-1"
}

variable "docker_image" {
  description = "The Docker image location in ECR or any accessible Docker registry."
}

variable "vpc_id" {
  description = "The ID of the VPC where resources will be deployed."
}

variable "subnet_ids" {
  description = "List of subnet IDs for deployment."
  type        = list(string)
}

