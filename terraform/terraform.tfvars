# terraform.tfvars

# AWS Region where resources will be deployed
aws_region = "us-west-2"

# VPC configuration
vpc_cidr_block = "10.0.0.0/16"
private_subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
availability_zones = ["us-west-2a", "us-west-2b"]

# Load Balancer configuration
listener_port         = 80
listener_protocol     = "HTTP"
target_group_port     = 80
target_group_protocol = "HTTP"

# S3 Bucket for static files
static_files_bucket_name = "crosswordpuzzle-app-unique-bucket-${random_suffix}"

# DynamoDB Table
dynamodb_table_name = "crosswordpuzzle-app-dynamodb-table-name"

# Lambda Function
lambda_function_name      = "crosswordpuzzle-app-lambda-function"
lambda_execution_role_arn = "crosswordpuzzle-app-lambda-execution-role-arn"

# Backend Configuration
aws_backend_bucketname = "crosswordpuzzle-app-backend-bucket-${random_suffix}"
aws_backend_bucket_key = "path/to/your/state.tfstate"
aws_dynamodb_table     = "terraform_state"