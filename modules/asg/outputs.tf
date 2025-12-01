output "asg_id" {
  description = "ID del Auto Scaling Group."
  value       = aws_autoscaling_group.this.id
}

output "asg_name" {
  description = "Nombre del Auto Scaling Group."
  value       = aws_autoscaling_group.this.name
}
