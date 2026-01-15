resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "eks-managed-nodes"

  node_role_arn = aws_iam_role.eks_nodes.arn

  subnet_ids = aws_subnet.public[*].id
 
  instance_types = ["t3.small"]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_policy,
    aws_iam_role_policy_attachment.ecr_read_only,
    aws_iam_role_policy_attachment.cni_policy
  ]
}
