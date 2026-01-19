resource "kubernetes_horizontal_pod_autoscaler_v2" "demo_app" {
  metadata {
    name      = "demo-app-hpa"
    namespace = "default"
  }

  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "demo-app"
    }

    min_replicas = 1
    max_replicas = 5

    metric {
      type = "Resource"
      resource {
        name                      = "cpu"
        target_type               = "Utilization"
        target_average_utilization = 50
      }
    }
  }
}

