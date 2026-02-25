## ------------------
## NGINX Ingress Reverse Proxy
## ------------------
resource "kubernetes_ingress_v1" "proxy" {
  metadata {
    name      = "kong-proxy"
    namespace = var.namespace
  }

  spec {
    ingress_class_name = "nginx"

    tls {
      hosts       = ["api.local.dev"]
      secret_name = "local-dev-tls"
    }

    rule {
      host = "api.local.dev"

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "kong-proxy"
              port { number = 8000 }
            }
          }
        }
      }
    }
  }
}


## ------------------
## Kong admin ingress
## ------------------
resource "kubernetes_ingress_v1" "admin" {
  metadata {
    name      = "kong-admin"
    namespace = var.namespace

    annotations = {
      "nginx.ingress.kubernetes.io/whitelist-source-range" = "192.168.49.0/24"
    }
  }

  spec {
    ingress_class_name = "nginx"

    tls {
      hosts       = ["admin.local.dev"]
      secret_name = "local-dev-tls"
    }

    rule {
      host = "admin.local.dev"

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "kong-admin"
              port { number = 8001 }
            }
          }
        }
      }
    }
  }
}

## -------------
## Kong manager ingress
## -------------
resource "kubernetes_ingress_v1" "manager" {
  metadata {
    name      = "kong-manager"
    namespace = var.namespace
  }

  spec {
    ingress_class_name = "nginx"

    tls {
      hosts       = ["gui.local.dev"]
      secret_name = "local-dev-tls"
    }

    rule {
      host = "gui.local.dev"

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "kong-admin-gui"
              port { number = 8002 }
            }
          }
        }
      }
    }
  }
}