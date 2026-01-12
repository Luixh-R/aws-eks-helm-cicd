resource "aws_ecr_repository" "app" {
  name = "eks-helm-app"

  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "eks-helm-app"
  }
}
