data "aws_ecr_repository" "existing" {
  name = "crosswordpuzzle-repository"
}

resource "aws_ecr_repository" "my_repository" {
  count = length(data.aws_ecr_repository.existing) > 0 ? 0 : 1
  name                 = "crosswordpuzzle-repository"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "delete_old_images" {
  repository = aws_ecr_repository.my_repository[0].name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 10 images",
            "selection": {
                "tagStatus": "untagged",
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

output "ecr_repository_url" {
  value       = aws_ecr_repository.my_repository[0].repository_url
  description = "The URL of the ECR repository"
}
