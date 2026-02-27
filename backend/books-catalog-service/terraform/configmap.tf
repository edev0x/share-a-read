resource "kubernetes_config_map" "books_config" {
  metadata {
    name      = "books-config"
    namespace = var.namespace
  }

  data = {
    SPRING_PROFILES_ACTIVE = "prod"
    DB_HOST = var.db_host
    DB_PORT = var.db_port
    DB_NAME = var.db_name
  }
}