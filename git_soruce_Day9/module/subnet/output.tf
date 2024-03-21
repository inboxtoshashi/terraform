output "private_subnet_id_result" {
  value = aws_subnet.private_subnet.id
}

output "public_subnet_id_result" {
  value = aws_subnet.public_subnet.id
}