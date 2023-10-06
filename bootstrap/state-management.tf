
data "external" "check_dynamodb_table" {
  program = ["bash", "${path.module}/check-dynamodb-table.sh"]
}

resource "random_string" "bucket_suffix_stmgmt" {
  length  = 8
  upper   = false
  number  = true
  special = false
}

data "aws_dynamodb_table" "existing" {
  count = var.check_existing_table ? 1 : 0
  name  = "terraform_state"
}

resource "aws_dynamodb_table" "terraform-lock" {
  count = data.external.check_dynamodb_table.result.exists == "false" ? 1 : 0

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

output "dynamodb_table_name" {
  value = data.external.check_dynamodb_table.result.exists == "true" ? data.external.check_dynamodb_table.result.table_name : aws_dynamodb_table.terraform-lock[0].name
}

output "s3_statemgmt_bucket_name" {
  value = aws_s3_bucket.statemgmt-bucket.bucket
  description = "The name of the S3 bucket used for Terraform state."
}
