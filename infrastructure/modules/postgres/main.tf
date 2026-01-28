############################
# Postgres admin secrets
############################
resource "kubernetes_secret" "admin" {
  for_each = var.postgres_instances

  metadata {
    name      = "${each.key}-postgres-admin"
    namespace = var.namespace
  }

  data = {
    POSTGRES_PASSWORD = base64encode(each.value.admin_password)
  }
}

############################
# Init SQL (users + dbs)
############################
resource "kubernetes_config_map" "init" {
  for_each = var.postgres_instances

  metadata {
    name      = "${each.key}-init"
    namespace = var.namespace
  }

  data = {
    "init.sql" = join("\n", flatten([
      for db in each.value.databases : [
        "CREATE USER ${db.user} WITH PASSWORD '${db.password}';",
        "CREATE DATABASE ${db.name} OWNER ${db.user};"
      ]
    ]))
  }
}

############################
# Postgres Service
############################
resource "kubernetes_service" "postgres" {
  for_each = var.postgres_instances

  metadata {
    name      = each.key
    namespace = var.namespace
    labels = {
      app = each.key
    }
  }

  spec {
    selector = {
      app = each.key
    }

    port {
      name        = "postgres"
      port        = 5432
      target_port = 5432
    }
  }
}

############################
# Postgres StatefulSet
############################
resource "kubernetes_stateful_set" "postgres" {
  for_each = var.postgres_instances

  metadata {
    name      = each.key
    namespace = var.namespace
    labels = {
      app = each.key
    }
  }

  spec {
    service_name = each.key
    replicas     = 1

    selector {
      match_labels = {
        app = each.key
      }
    }

    template {
      metadata {
        labels = {
          app = each.key
        }
      }

      spec {
        container {
          name  = "postgres"
          image = "postgres:15-alpine"

          ############################
          # Env
          ############################
          env {
            name = "POSTGRES_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.admin[each.key].metadata[0].name
                key  = "POSTGRES_PASSWORD"
              }
            }
          }

          ############################
          # Ports
          ############################
          port {
            name           = "postgres"
            container_port = 5432
          }

          ############################
          # Volume mounts
          ############################
          volume_mount {
            name       = "data"
            mount_path = "/var/lib/postgresql/data"
          }

          volume_mount {
            name       = "init"
            mount_path = "/docker-entrypoint-initdb.d"
          }
        }

        ############################
        # Init SQL volume
        ############################
        volume {
          name = "init"
          config_map {
            name = kubernetes_config_map.init[each.key].metadata[0].name
          }
        }
      }
    }

    ############################
    # Persistent storage
    ############################
    volume_claim_template {
      metadata {
        name = "data"
      }

      spec {
        access_modes = ["ReadWriteOnce"]

        resources {
          requests = {
            storage = "2Gi"
          }
        }
      }
    }
  }
}
