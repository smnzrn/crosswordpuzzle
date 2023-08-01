variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_backend_bucketname" {
  description = "S3 backend bucket name"
  type        = string
  default     = "my-terraform-state-bucket"
}

variable "aws_backend_bucket_key" {
  description = "S3 backend bucket key"
  type        = string
  default     = "crossword_puzzle_app/terraform.tfstate"
}

variable "instance_type" {
  description = "Size of the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "load_balancer_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "listener_port" {
  description = "Port for the load balancer listener"
  type        = number
}

variable "listener_protocol" {
  description = "Protocol for the load balancer listener"
  type        = string
  default     = "HTTP"
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
  default     = 5000
}

variable "target_group_protocol" {
  description = "Protocol for the target group"
  type        = string
  default     = "HTTP"
}

variable "target_group_health_url" {
  description = "Health check URL for the target group"
  type        = string
}

variable "certificate_arn" {
  description = "ARN of the SSL certificate"
  type        = string
}

variable "lambda_function_name" {
  description = "Lambda function name"
  type        = string
  default     = "crosswordpuzzle-generator-lambda"
}
variable "static_files_bucket_name" {
  description = "S3 static files bucket name"
  type        = string
  default     = "static-files"
}