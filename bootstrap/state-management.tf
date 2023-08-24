resource "random_string" "bucket_suffix_stmgmt" {
  length  = 8
  upper   = false
  number  = true
  special = false
}

resource "aws_s3_bucket" "statemgmt-bucket" {
  bucket = "${var.statemgmt_bucket_name}-${random_string.bucket_suffix_stmgmt.result}"
  object_lock_configuration {
    object_lock_enabled = "Enabled"
  }
}
  
resource "aws_dynamodb_table" "terraform-lock" {
  name = "terraform_state"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "s3_statemgmt_bucket_name" {
  value = aws_s3_bucket.statemgmt-bucket.bucket
  description = "The name of the S3 bucket used for Terraform state."
}
