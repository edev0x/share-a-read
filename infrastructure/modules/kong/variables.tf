variable "namespace" {
  type = string
}

variable "kong" {
  type = object({
    pg_database = string
    pg_user     = string
    pg_password = string
  })
}

variable "postgres_service_name" {
  type = string
}
