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

          ## -------------
          # REQUIRED PORTS FOR KONG SERVICES
          ## -------------
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

          ## NGINX TLS
          ## PROXY LISTENER
          env {
            name  = "KONG_PROXY_LISTEN"
            value = "0.0.0.0:8000"
          }

          # Admin LISTENER
          env {
            name  = "KONG_ADMIN_LISTEN"
            value = "0.0.0.0:8001"
          }

          env {
            name  = "KONG_TRUSTED_IPS"
            value = "0.0.0.0/0,::/0"
          }

          env {
            name  = "KONG_REAL_IP_HEADER"
            value = "X-Forwarded-For"
          }

          # Kong manager LISTENER
          env {
            name  = "KONG_ADMIN_GUI_LISTEN"
            value = "0.0.0.0:8002"
          }

          env {
            name  = "KONG_ADMIN_GUI_URL"
            value = "https://gui.local.dev"
          }

          env {
            name  = "KONG_ADMIN_API_URL"
            value = "https://admin.local.dev"
          }

          env {
            name  = "KONG_PROXY_URL"
            value = "https://api.local.dev"
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
        }
      }
    }
  }
}


## -------------
## KONG PROXY
## -------------
resource "kubernetes_service" "proxy" {
  metadata {
    name      = "kong-proxy"
    namespace = var.namespace
  }

  spec {
    selector = { app = "kong" }

    port {
      port        = 8000
      target_port = 8000
    }
  }
}


## -------------
## KONG ADMIN
## -------------
resource "kubernetes_service" "admin" {

  metadata {
    name      = "kong-admin"
    namespace = var.namespace
  }

  spec {
    selector = { app = "kong" }

    port {
      port        = 8001
      target_port = 8001
    }
  }
}

## -------------
## KONG MANAGER GUI
## -------------
resource "kubernetes_service" "manager" {
  metadata {
    name      = "kong-admin-gui"
    namespace = var.namespace
  }

  spec {
    selector = { app = "kong" }

    port {
      port        = 8002
      target_port = 8002
    }
  }
}