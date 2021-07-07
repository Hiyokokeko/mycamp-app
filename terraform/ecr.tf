# ECR
## api
resource "aws_ecr_repository" "mycamp-api" {
  name                 = "mycamp-api"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

## front
resource "aws_ecr_repository" "mycamp-front" {
  name                 = "mycamp-front"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
