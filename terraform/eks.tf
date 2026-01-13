resource "aws_eks_cluster" "this" {
  name = "eks-helm-cluster"

  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config{
    subnet_ids = aws_subnet.public[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}
