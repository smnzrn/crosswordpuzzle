resource "random_string" "bucket_suffix_sf" {
  length  = 8
  upper   = false
  number  = true
  special = false
}

resource "aws_s3_bucket" "staticfiles-bucket" {
  bucket = "${var.staticfiles_bucket_name}-${random_string.bucket_suffix_sf.result}"
  object_lock_configuration {
    object_lock_enabled = "Enabled"
  }
}

output "s3_staticfiles_bucket_name" {
  value = aws_s3_bucket.statemgmt-bucket.bucket
  description = "The name of the S3 bucket used for Terraform state."
}
