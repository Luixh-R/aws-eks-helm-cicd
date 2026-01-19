provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}

resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  namespace  = "kube-system"

  values = [
    yamlencode({
      autoDiscovery = {
        clusterName = "eks-helm-cluster"
      }
      awsRegion           = "us-east-1"
      rbac = {
        serviceAccount = {
          create = false
          name   = "cluster-autoscaler"
        }
      }
      extraArgs = {
        "skip-nodes-with-local-storage" = false
        "expander" = "least-waste"
      }
    })
  ]
}

