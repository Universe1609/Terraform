#Definimos una salida que exponga el ID del grupo de seguridad SG-1
output "security_group_id_1" {
  value = aws_security_group.SG-1.id
}

output "security_group_id_2" {
  value = aws_security_group.SG-2.id
}

output "subnet_id_1" {
  value = aws_subnet.my_subnet_1.id
}
