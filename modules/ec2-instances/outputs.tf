output "instancia_1" {
  value = aws_instance.Tuenti.id
}

output "instancia_2" {
  value = aws_instance.Backup.id
}
