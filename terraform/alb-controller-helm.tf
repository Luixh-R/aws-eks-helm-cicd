resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  namespace  = "kube-system"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.7.2"

  values = [yamlencode({
    clusterName = aws_eks_cluster.this.name

    serviceAccount = {
      create = false
      name   = kubernetes_service_account_v1.alb_controller.metadata[0].name
    }

    region = var.region
    vpcId  = aws_vpc.this.id
  })]

  depends_on = [
    kubernetes_service_account_v1.alb_controller,
    aws_iam_role_policy_attachment.alb_controller
  ]
}

