output "nat_gateway_id" {
  description = "ID del NAT Gateway creado."
  value       = aws_nat_gateway.this.id
}

output "nat_gateway_eip" {
  description = "IP pública asociada al NAT Gateway."
  value       = aws_eip.this.public_ip
}
