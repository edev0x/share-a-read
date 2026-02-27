resource "kubernetes_secret" "tls" {
    metadata {
        name = "local-dev-tls"
        namespace = var.namespace
    }

    type = "kubernetes.io/tls"

    data = {
        "tls.crt" = "${path.module}/certs/local-dev.pem"
        "tls.key" = "${path.module}/certs/local-dev-key.pem"
    }
}