# Example usage of VPC module
module "vpc" {
  source               = "../../../modules/vpc"
  vpc_name             = "example-vpc"
  cidr_block           = "10.0.0.0/16"
  public_subnet_cidrs  = {
    "public-1" = "10.0.1.0/24"
    "public-2" = "10.0.2.0/24"
  }
  private_subnet_cidrs = {
    "private-1" = "10.0.3.0/24"
    "private-2" = "10.0.4.0/24"
  }
  availability_zones   = {
    "public-1"  = "eu-west-1a"
    "public-2"  = "eu-west-1b"
    "private-1" = "eu-west-1a"
    "private-2" = "eu-west-1b"
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}
