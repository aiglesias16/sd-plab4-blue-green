output "alb_arn" {
  description = "ARN del ALB."
  value       = aws_lb.this.arn
}

output "alb_dns_name" {
  description = "DNS del ALB."
  value       = aws_lb.this.dns_name
}

output "blue_target_group_arn" {
  description = "ARN del target group blue."
  value       = aws_lb_target_group.blue.arn
}

output "green_target_group_arn" {
  description = "ARN del target group green."
  value       = aws_lb_target_group.green.arn
}
