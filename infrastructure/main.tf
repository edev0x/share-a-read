module "namespace" {
  source    = "./modules/namespace"
  namespace = var.namespace
}

module "postgres" {
  source             = "./modules/postgres"
  namespace          = var.namespace
  postgres_instances = var.postgres_instances

  depends_on = [module.namespace]
}

module "rabbitmq" {
  source    = "./modules/rabbitmq"
  namespace = var.namespace
  rabbitmq  = var.rabbitmq

  depends_on = [module.namespace]
}

module "kong" {
  source    = "./modules/kong"
  namespace = var.namespace
  kong      = var.kong

  postgres_service_name = "kong-postgres"

  depends_on = [
    module.namespace,
    module.postgres
  ]
}
