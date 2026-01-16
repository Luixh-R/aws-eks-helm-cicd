resource "kubernetes_config_map_v1" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode([
      {
        rolearn  = aws_iam_role.eks_nodes.arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = [
          "system:bootstrappers",
          "system:nodes"
        ]
      }
    ])

    mapUsers = yamlencode([
      {
        userarn  = aws_iam_role.github_actions.arn
        username = "github-actions"
        groups   = ["system:masters"]
      },
      {
        userarn  = data.aws_caller_identity.current.arn
        username = "admin"
        groups   = ["system:masters"]
      }
    ])
  }
}

