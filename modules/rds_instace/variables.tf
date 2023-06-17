variable "secreto" {
  default = "nombre_del_secreto"
}

variable "secreto_string" {
  default = "secreto-a-proteger"
}
variable "storage" {
  default = 20
}

variable "engine" {
  default = "mysql"
}

variable "engine_version" {
  default = "5.7"
}

variable "instance_class" {
  default = "db.t2.micro"
}

variable "name" {
  default = "DB_name"
}

variable "username" {
  default = "usuario"
}

variable "parameter" {
  default = "default.mysql5.7"
}
