
variable "check_existing_table" {
  description = "Set to true if you want to check for the existing table. Default is false, meaning it will always try to create a new table."
  default     = true
}

variable "statemgmt_bucket_name" {
  description = "The base name for the S3 bucket to store Terraform state."
  type        = string
  default     = "mycrosswordpuzzle-statemgmt"  # You can change this default as per your preference.
}

variable "staticfiles_bucket_name" {
  description = "The base name for the S3 bucket to store Terraform state."
  type        = string
  default     = "mycrosswordpuzzle-staticfiles"  # You can change this default as per your preference.
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
