terraform {
 backend "s3" {
   bucket = var.aws_backend_bucketname
   key = var.aws_backend_bucket_key
   region = var.aws_region
   dynamodb_table = var.aws_dynamodb_table
 }
}
