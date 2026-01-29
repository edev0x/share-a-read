resource "kubernetes_job" "flyway" {
  metadata {
    name = "books-flyway"
    namespace = var.namespace
  }

  spec {
    backoff_limit = 1
    template {
      metadata {}

      spec {
        restart_policy = "Never"

        container {
          name = "flyway"
          image = "books-catalog-flyway:latest"
          image_pull_policy = "Never"

          args = [
            "-url=jdbc:postgresql://books-catalog:5432/${var.db_name}",
            "-user=${var.db_user}",
            "-password=${var.db_password}",
            "migrate"
          ]
        }
      }
    }
  }
}
