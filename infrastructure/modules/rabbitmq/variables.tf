variable "namespace" {
  type = string
}

variable "rabbitmq" {
  type = object({
    username = string
    password = string
  })
}
