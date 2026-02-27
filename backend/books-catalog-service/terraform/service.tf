resource "kubernetes_service" "books-catalog-service" {
  metadata {
    name      = "books-catalog-service"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "books-catalog-service"
    }

    port {
      port        = 8080
      target_port = 8080
    }

    type = "ClusterIP"
  }
}
