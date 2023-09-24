data "aws_ecr_repository" "existing" {
  name = "crosswordpuzzle-repository"
}

locals {
  repository_exists = try(length(data.aws_ecr_repository.existing.*.repository_url), 0) > 0 ? true : false
}

resource "aws_ecr_repository" "my_repository" {
  count = local.repository_exists ? 0 : 1
  name                 = "crosswordpuzzle-repository"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "delete_old_images" {
  count      = local.repository_exists ? 0 : 1
  repository = aws_ecr_repository.my_repository[count.index].name

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
  value       = local.repository_exists ? data.aws_ecr_repository.existing.repository_url : aws_ecr_repository.my_repository[0].repository_url
  description = "The URL of the ECR repository"
}