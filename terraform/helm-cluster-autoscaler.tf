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

