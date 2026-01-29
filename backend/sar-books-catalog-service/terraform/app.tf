resource "kubernetes_deployment" "sar-books-catalog-service" {
  depends_on = [kubernetes_job.flyway]

  metadata {
    name      = "sar-books-catalog-service"
    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "sar-books-catalog-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "sar-books-catalog-service"
        }
      }

      spec {
        container {
          name              = "sar-books-catalog-service"
          image             = "sar-books-catalog-service:latest"
          image_pull_policy = "Never"

          env {
            name  = "SPRING_DATASOURCE_URL"
            value = "jdbc:postgresql://${var.db_host}:5432/${var.db_name}"
          }

          env {
            name  = "SPRING_DATASOURCE_USERNAME"
            value = var.db_user
          }

          env {
            name  = "SPRING_DATASOURCE_PASSWORD"
            value = var.db_password
          }

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}
