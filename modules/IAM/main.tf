resource "aws_iam_user" "usuario_1" {
  name = "usuario_1"
  path = "/system/"
}

resource "aws_iam_user" "usuario_2" {
  name = "usuario_2"
  path = "/system/"
}

resource "aws_iam_access_key" "pb_1" {
  user = aws_iam_user.usuario_1.name
}

resource "aws_iam_access_key" "pb_2" {
  user = aws_iam_user.usuario_2.name
}

resource "aws_iam_group" "grupo_de_seguridad" {
  name = "grupo_de_seguridad"
  path = "/users/"
}

resource "aws_iam_group" "grupo_de_desarrollo" {
  name = "grupo_de_desarrollo"
}

resource "aws_iam_group_membership" "example_1" {
  name = "group_memvership"
  users = [
    aws_iam_user.usuario_1.name,
    aws_iam_user.usuario_2.name
  ]
  group = aws_iam_group.grupo_de_desarrollo.name
}

resource "aws_iam_group_membership" "example_2" {
  name = "group_membership_"
  users = [
    aws_iam_user.usuario_1.name
  ]
  group = aws_iam_group.grupo_de_seguridad.name
}

resource "aws_iam_group_policy_attachment" "admin" {
  group      = aws_iam_group.grupo_de_seguridad.name
  policy_arn = var.admin
}
