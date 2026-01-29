resource "kubernetes_config_map" "db_config" {
  metadata {
    name = "books-db-config"
  }

  data = {
    DB_NAME = "books_catalog_db"
  }
}
