resource "kubernetes_job" "kong_migrations" {
  metadata {
    name      = "kong-migrations"
    namespace = var.namespace
  }

  spec {
    template {
      metadata {
        name = "kong-migrations"
      }

      spec {
        restart_policy = "OnFailure"

        init_container {
          name  = "wait-for-postgres"
          image = "busybox:latest"
          command = [
            "sh",
            "-c",
            "until nc -zv $KONG_PG_HOST $KONG_PG_PORT -w1; do echo 'Waiting for postgres...'; sleep 2; done;"
          ]
        }

        container {
          name  = "kong-migrations"
          image = "kong:3.6"

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
            name = "KONG_PG_DATABASE"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.kong_db.metadata[0].name
                key  = "PG_DATABASE"
              }
            }
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

          command = ["kong", "migrations", "bootstrap"]
        }
      }
    }
  }
}
