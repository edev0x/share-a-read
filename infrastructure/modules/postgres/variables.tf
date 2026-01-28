variable "namespace" {
  type = string
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
