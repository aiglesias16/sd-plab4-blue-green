module "alb_blue_green" {
    source             = "../../../modules/alb-gb"
    name               = "blue-green-alb"
    subnet_ids         = ["subnet-xxxx", "subnet-yyyy"]
    security_group_ids = ["sg-xxxx"]
    internal           = false
    vpc_id             = "vpc-xxxx"
    blue_weight        = 80
    green_weight       = 20
    tags = {
        Environment = "dev"
    }
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
