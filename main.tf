# Provider block for AWS
provider "aws" {
  region = var.aws_region
}

# VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "MainVPC"
  }
}

# Subnets
resource "aws_subnet" "private" {
  count             = 2
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  vpc_id            = aws_vpc.main.id
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "PrivateSubnet-${count.index + 1}"
  }
}

# Security Group for Lambda
resource "aws_security_group" "lambda_security_group" {
  name_prefix = "LambdaSG-"
  vpc_id      = aws_vpc.main.id

  # Ingress rule to allow Lambda to communicate with other resources within the VPC
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"] # Assuming your VPC CIDR block is 10.0.0.0/16
  }
}

# S3 Bucket for static files
resource "aws_s3_bucket" "static_files" {
  bucket = var.static_files_bucket_name
  acl    = "private"

  # Optionally, enable website hosting if needed
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

# Generate a random suffix for the bucket name
resource "random_string" "bucket_suffix" {
  length  = 6   # Adjust the length of the random suffix as needed
  special = false
}

# DynamoDB Table
resource "aws_dynamodb_table" "crossword_puzzles" {
  name           = var.dynamodb_table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
  attribute {
    name = "id"
    type = "S"
  }
}

# Load Balancer
resource "aws_lb" "main" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"
  subnets            = aws_subnet.private.*.id

  # HTTP Listener
  listener {
    port = var.listener_port
    protocol = var.listener_protocol
  }

  # Target Group
  target_group {
    name     = "main-target-group"
    port     = var.target_group_port
    protocol = var.target_group_protocol
    vpc_id   = aws_vpc.main.id
  }
}

# Lambda Function
resource "aws_lambda_function" "puzzle_generator" {
  function_name = var.lambda_function_name
  filename      = "lambda/puzzle_generator.zip"
  role          = var.lambda_execution_role_arn
  handler       = "puzzle_generator.generate_puzzle"
  runtime       = "python3.8"
  timeout       = 10

  environment {
    variables = {
      S3_BUCKET_NAME = aws_s3_bucket.static_files.bucket
    }
  }

  # Configure VPC settings if your Lambda needs to access resources within the VPC
  vpc_config {
    subnet_ids         = aws_subnet.private.*.id
    security_group_ids = [aws_security_group.lambda_security_group.id]
  }
}

# Output the Load Balancer DNS Name
output "load_balancer_dns_name" {
  value = aws_lb.main.dns_name
}