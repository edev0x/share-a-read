resource "kubernetes_secret" "books_db_secret" {
  metadata {
    name      = "books-db-secret"
    namespace = var.namespace
  }

  data = {
    DB_USER = var.db_user
    DB_PASS = var.db_password
  }

  type = "Opaque"
}