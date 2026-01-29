resource "kubernetes_service" "sar-books-catalog-service" {
  metadata {
    name      = "sar-books-catalog-service"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "sar-books-catalog-service"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "NodePort"
  }
}
