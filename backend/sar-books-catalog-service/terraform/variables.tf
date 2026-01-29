variable "namespace" {
  default = "infra"
}

variable "db_name" {
  default = "books_catalog_db"
}

variable "db_user" {
  default = "books_db_user"
}

variable "db_password" {
  default = "books_db_pass"
}

variable "db_host" {
  default = "books-catalog"
}

variable "migration_version" {
  default = "v1"
}