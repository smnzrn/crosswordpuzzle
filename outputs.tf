output "website_url" {
  value = aws_lb.crossword_lb.dns_name
}

output "ecr_repository_url" {
  value = aws_ecr_repository.my_repository.repository_url
}
