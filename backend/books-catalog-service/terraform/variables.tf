variable "namespace" {
  default = "infra"
}

variable "db_name" {
  default = "books_catalog_db"
  type = string
}

variable "db_user" {
  default = "books_db_user"
  type = string
}

variable "db_password" {
  default = "books_db_pass"
  sensitive = true
  type = string
}

variable "db_port" {
  default = 5432
  type = number
}

variable "db_host" {
  default = "books-catalog"
  type = string
}

variable "migration_version" {
  default = "v1"
}