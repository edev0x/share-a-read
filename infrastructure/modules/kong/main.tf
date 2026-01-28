resource "kubernetes_secret" "kong_db" {
  metadata {
    name      = "kong-db-secret"
    namespace = var.namespace
  }

  data = {
    PG_DATABASE = base64encode(var.kong.pg_database)
    PG_USER     = base64encode(var.kong.pg_user)
    PG_PASSWORD = base64encode(var.kong.pg_password)
  }
}


resource "kubernetes_deployment" "kong" {
  metadata {
    name      = "kong"
    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = { app = "kong" }
    }

    template {
      metadata {
        labels = { app = "kong" }
        namespace = var.namespace
      }

      spec {
        container {
          name  = "kong"
          image = "kong:3.9"

          env {
            name  = "KONG_DATABASE"
            value = "postgres"
          }

          env {
            name  = "KONG_PG_HOST"
            value = "kongpg"
          }

          env {
            name  = "KONG_PG_PORT"
            value = "5432"
          }

          env {
            name  = "KONG_PG_DATABASE"
            value = "kong"
          }

          env {
            name  = "KONG_PG_USER"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.kong_db.metadata[0].name
                key  = "PG_USER"
              }
            }
          }

          env {
            name  = "KONG_PG_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.kong_db.metadata[0].name
                key  = "PG_PASSWORD"
              }
            }
          }

          env {
            name  = "KONG_PROXY_LISTEN"
            value = "0.0.0.0:8000"
          }

          port {
            container_port = 8000
          }
        }
      }
    }
  }

  depends_on = [
    kubernetes_job.kong_migrations
  ]
}