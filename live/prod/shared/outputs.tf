output "vpc_id" { 
    value = module.vpc.vpc_id 
}
output "public_subnet_ids" { 
    value = module.vpc.public_subnet_ids 
}
output "private_subnet_ids" { 
    value = module.vpc.private_subnet_ids 
}
output "security_group_id" { 
    value = module.security_group.security_group_id 
}
output "alb_dns_name" { 
    value = module.alb_blue_green.alb_dns_name 
}
output "blue_target_group_arn" { 
    value = module.alb_blue_green.blue_target_group_arn 
}
output "green_target_group_arn" { 
    value = module.alb_blue_green.green_target_group_arn 
}