
variable "check_existing_table" {
  description = "Set to true if you want to check for the existing table. Default is false, meaning it will always try to create a new table."
  default     = false
}

data "aws_dynamodb_table" "existing" {
  count = var.check_existing_table ? 1 : 0
  name  = "terraform_state"
}

resource "aws_dynamodb_table" "terraform-lock" {
  count = var.check_existing_table && length(data.aws_dynamodb_table.existing.*.name) > 0 ? 0 : 1

  name         = "terraform_state"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "statemgmt-bucket" {
  bucket = "${var.statemgmt_bucket_name}-${random_string.bucket_suffix_stmgmt.result}"
  object_lock_configuration {
    object_lock_enabled = "Enabled"
  }
}

output "s3_statemgmt_bucket_name" {
  value = aws_s3_bucket.statemgmt-bucket.bucket
  description = "The name of the S3 bucket used for Terraform state."
}
