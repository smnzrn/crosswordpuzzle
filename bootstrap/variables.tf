variable "base_bucket_name" {
  description = "The base name for the S3 bucket to store Terraform state."
  type        = string
  default     = "mycrosswordpuzzle"  # You can change this default as per your preference.
}

variable "aws_region" {
  description = "The AWS region in which resources should be created."
  type        = string
  default     = "us-east-1"  # Adjust to your preferred region if different.
}

variable "aws_backend_bucket_key" {
  description = "The key under which to store the Terraform state in the S3 bucket."
  type        = string
  default     = "terraform.tfstate"
}

variable "aws_dynamodb_table" {
  description = "The name of the DynamoDB table used for state locking."
  type        = string
  default     = "terraform_state"
}
