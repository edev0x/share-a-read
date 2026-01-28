output "kong_url" {
  value = "minikube service kong -n infra"
}

output "postgres_services" {
  value = [for k in keys(var.postgres_instances) : "${k}.infra.svc.cluster.local"]
}
