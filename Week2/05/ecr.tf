#count를 사용하여 리소스 생성
resource "aws_ecr_repository" "gril_count_ecr" {
  count = length(var.repository_names)
  name  = var.repository_names[count.index]
  tags = {
    Name = var.repository_names[count.index]
  }
}

# for_each를 사용하여 리소스 생성
resource "aws_ecr_repository" "gril_foreach_ecr" {
  for_each = var.repositories
  name     = each.key
  image_scanning_configuration {
    scan_on_push = each.value.scan_on_push
  }
  tags = {
    Name = each.key
  }
}


output "gril_count_ecr" {
  value = {for r in aws_ecr_repository.gril_count_ecr : r.name => r.repository_url}
}

output "gril_foreach_ecr" {
  value = {for r in aws_ecr_repository.gril_foreach_ecr : r.name => r.repository_url}
}