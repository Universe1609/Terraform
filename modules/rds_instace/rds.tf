resource "aws_secretsmanager_secret" "db_password" {
  name = var.secreto
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = var.secreto_string
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = aws_secretsmanager_secret.db_password.id
}

resource "aws_db_instance" "default" {
  allocated_storage    = var.storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_name              = var.name
  username             = var.username
  password             = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)["password"]
  parameter_group_name = var.parameter

}
