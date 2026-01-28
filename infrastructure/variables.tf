variable "host" {
  type    = string
  default = "https://127.0.0.1:57529"
}

variable "namespace" {
  type    = string
  default = "infra"
}

variable "postgres_instances" {
  type = map(object({
    admin_password = string
    databases = map(object({
      name     = string
      user     = string
      password = string
    }))
  }))
}

variable "kong" {
  type = object({
    pg_database = string
    pg_user     = string
    pg_password = string
  })
}

variable "rabbitmq" {
  type = object({
    username = string
    password = string
  })
}
