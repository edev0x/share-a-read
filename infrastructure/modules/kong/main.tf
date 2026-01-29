resource "kubernetes_secret" "kong_db" {
  metadata {
    name      = "kong-db-credentials"
    namespace = var.namespace
  }

  data = {
    PG_DATABASE = var.kong.pg_database
    PG_USER     = var.kong.pg_user
    PG_PASSWORD = var.kong.pg_password
  }
}


resource "kubernetes_deployment" "kong" {

  depends_on = [
    kubernetes_job.kong_migrations
  ]

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
        labels    = { app = "kong" }
        namespace = var.namespace
      }

      spec {
        container {
          name  = "kong"
          image = "kong:3.9"

          # Proxy
          env {
            name  = "KONG_PROXY_LISTEN"
            value = "0.0.0.0:8000"
          }

          # Admin API
          env {
            name  = "KONG_ADMIN_LISTEN"
            value = "0.0.0.0:8001"
          }

          # Kong manager GUI
          env {
            name  = "KONG_ADMIN_GUI_LISTEN"
            value = "0.0.0.0:8002"
          }

          # URLs for port-forward access
          env {
            name  = "KONG_ADMIN_GUI_URL"
            value = "http://localhost:8002"
          }

          env {
            name  = "KONG_ADMIN_API_URI"
            value = "http://localhost:8001"
          }


          env {
            name  = "KONG_DATABASE"
            value = "postgres"
          }

          env {
            name  = "KONG_PG_HOST"
            value = "kong-postgres"
          }

          env {
            name  = "KONG_PG_PORT"
            value = "5432"
          }

          env {
            name  = "KONG_PG_DATABASE"
            value = "kong_db"
          }

          env {
            name = "KONG_PG_USER"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.kong_db.metadata[0].name
                key  = "PG_USER"
              }
            }
          }

          env {
            name = "KONG_PG_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.kong_db.metadata[0].name
                key  = "PG_PASSWORD"
              }
            }
          }

          port {
            name           = "proxy"
            container_port = 8000
          }

          port {
            name           = "admin-api"
            container_port = 8001
          }

          port {
            name           = "admin-gui"
            container_port = 8002
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "kong" {
  metadata {
    name      = "kong"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "kong"
    }

    port {
      name        = "proxy"
      port        = 8000
      target_port = 8000
    }

    port {
      name        = "admin-api"
      port        = 8001
      target_port = 8001
    }

    port {
      name        = "admin-gui"
      port        = 8002
      target_port = 8002
    }

    type = "ClusterIP"
  }
}
