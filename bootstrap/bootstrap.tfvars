statemgmt_bucket_name      = "mycrosswordpuzzle-statemgmt"  # This is an example. Adjust based on your stage/environment.
staticfiles_bucket_name    = "mycrosswordpuzzle-staticfiles"
aws_region            = "us-east-1"      # Adjust if you're deploying to a different region.
aws_backend_bucket_key = "terraform.tfstate"
aws_dynamodb_table    = "terraform_state"
