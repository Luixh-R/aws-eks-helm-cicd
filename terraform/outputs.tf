output "vpc_id" {
 value = aws_vpc.this.id
}

output "public_subnet_ids" {
 value = aws_subnet.public[*].id
}

output "ecr_repository_url" {
 value = aws_ecr_repository.app.repository_url
}

output "eks_cluster_name" {
 value = aws_eks_cluster.this.name
}

output "eks_cluster_endpoint" {
 value = aws_eks_cluster.this.endpoint
}

output "eks_node_group_name" {
 value = aws_eks_node_group.this.node_group_name
}

output "github_actions_role_arn" {
 description = "IAM Role ARN for GitHub Actions OIDC"
 value       = aws_iam_role.github_actions.arn
}
