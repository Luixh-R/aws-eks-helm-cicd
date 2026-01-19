resource "helm_release" "monitoring" {
  name             = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = "monitoring"
  create_namespace = true

  values = [
    yamlencode({
      grafana = {
        adminPassword = "ChangeMe123!"
      }
      prometheus = {
        prometheusSpec = {
          serviceMonitorSelectorNilUsesHelmValues = false
        }
      }
    })
  ]
}

