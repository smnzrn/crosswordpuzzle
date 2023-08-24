resource "random_string" "bucket_suffix" {
  length  = 8
  upper   = false
  numbers = true
  special = false
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.staticfiles_bucket_name}-${random_string.bucket_suffix.result}"
  object_lock_configuration {
    object_lock_enabled = "Enabled"
  }
}
