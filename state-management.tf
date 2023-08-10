resource "aws_s3_bucket" "bucket" {
 bucket = var.aws_backend_bucketname
 object_lock_configuration {
   object_lock_enabled = "Enabled"
 }
}
  
resource "aws_dynamodb_table" "terraform-lock" {
 name = "terraform_state"
 read_capacity = 5
 write_capacity = 5
 hash_key = "LockID"
 attribute {
   name = "LockID"
   type = "S"
 }
}
