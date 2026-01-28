resource "kubernetes_secret" "rabbitmq" {
  metadata {
    name      = "rabbitmq-secret"
    namespace = var.namespace
  }

  data = {
    RABBITMQ_USER = base64encode(var.rabbitmq.username)
    RABBITMQ_PASS = base64encode(var.rabbitmq.password)
  }
}


resource "kubernetes_deployment" "rabbitmq" {
  metadata {
    name      = "rabbitmq"
    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = { app = "rabbitmq" }
    }

    template {
      metadata {
        labels = { app = "rabbitmq" }
      }

      spec {
        container {
          name  = "rabbitmq"
          image = "rabbitmq:4.0-management"

          env {
            name = "RABBITMQ_DEFAULT_USER"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.rabbitmq.metadata[0].name
                key  = "RABBITMQ_USER"
              }
            }
          }

          env {
            name = "RABBITMQ_DEFAULT_PASS"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.rabbitmq.metadata[0].name
                key  = "RABBITMQ_PASS"
              }
            }
          }
        }
      }
    }
  }
}
