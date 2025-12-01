output "launch_template_id" {
  description = "ID del Launch Template."
  value       = aws_launch_template.this.id
}

output "launch_template_name" {
  description = "Nombre del Launch Template."
  value       = aws_launch_template.this.name
}
