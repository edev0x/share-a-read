resource "kubernetes_deployment" "books-catalog-service" {
  metadata {
    name      = "books-catalog-service"
    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "books-catalog-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "books-catalog-service"
        }
      }

      spec {
        container {
          name              = "books-catalog-service"
          image             = "books-catalog-service:latest"
          image_pull_policy = "Never"

          env_from {
            config_map_ref {
              name = kubernetes_config_map.books_config.metadata[0].name
            }
          }

          env_from {
            secret_ref {
              name = kubernetes_secret.books_db_secret.metadata[0].name
            }
          }

          resources {
            limits = {
              cpu = "500m"
              memory = "512Mi"
            }

            requests = {
              cpu = "200m"
              memory = "256Mi"
            }
          }

          readiness_probe {
            http_get {
              path = "/actuator/health/readiness"
              port = 8080
            }
            period_seconds = 5
            timeout_seconds = 2
          }

          liveness_probe {
            http_get {
              path = "/actuator/health/liveness"
              port = 8080
            }
            period_seconds = 10
            timeout_seconds = 2
          }

          startup_probe {
            http_get {
              path = "/actuator/health"
              port = "8080"
            }
            failure_threshold = 12
            period_seconds = 10
            initial_delay_seconds = 30
            timeout_seconds = 3
          }

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}
