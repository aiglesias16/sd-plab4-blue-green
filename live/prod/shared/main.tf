module "vpc" {
  source = "../../../modules/vpc"
  vpc_name = "prod-vpc"
  cidr_block = "10.0.0.0/16"
  public_subnet_cidrs = {
    "public-1" = "10.0.1.0/24"
    "public-2" = "10.0.2.0/24"
  }
  private_subnet_cidrs = {
    "private-1" = "10.0.3.0/24"
    "private-2" = "10.0.4.0/24"
  }
  availability_zones = {
    "public-1" = "eu-west-1a"
    "public-2" = "eu-west-1b"
    "private-1" = "eu-west-1a"
    "private-2" = "eu-west-1b"
  }
}

module "internet_gateway" {
  source = "../../../modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
}

module "nat_gateway_public_1" {
  source    = "../../../modules/nat_gateway"
  subnet_id = module.vpc.public_subnet_ids["public-1"]
}

module "nat_gateway_public_2" {
  source    = "../../../modules/nat_gateway"
  subnet_id = module.vpc.public_subnet_ids["public-2"]
}

module "security_group_alb" {
  source = "../../../modules/security_group"
  name = "prod-sg"
  vpc_id = module.vpc.vpc_id
  ingress = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      security_groups = []
      description = "Allow HTTP"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      security_groups = []
      description = "Allow HTTPS"
    }
  ]
  egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound"
    }
  ]
}

module "security_group_blue_green" {
  source  = "../../../modules/security_group"
  name    = "blue-green-ec2-sg"
  vpc_id  = module.vpc.vpc_id
  ingress = [
    {
      from_port       = 80
      to_port         = 80
      protocol        = "tcp"
      security_groups = [module.security_group_alb.security_group_id]
      cidr_blocks     = []
      description     = "Allow HTTP from ALB"
    }
  ]
  egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound"
    }
  ]
}


module "alb_blue_green" {
  source             = "../../../modules/alb-gb"
  name               = "prod-alb"
  subnet_ids         = [module.vpc.public_subnet_ids["public-1"], module.vpc.public_subnet_ids["public-2"]]
  security_group_ids = [module.security_group_alb.security_group_id]
  internal           = false
  vpc_id             = module.vpc.vpc_id
  blue_weight        = 50
  green_weight       = 50
}

resource "aws_route_table" "public_1" {
  vpc_id = module.vpc.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.internet_gateway.internet_gateway_id
  }
  tags = { Name = "public-1-rt" }
}

resource "aws_route_table" "public_2" {
  vpc_id = module.vpc.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.internet_gateway.internet_gateway_id
  }
  tags = { Name = "public-2-rt" }
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = module.vpc.public_subnet_ids["public-1"]
  route_table_id = aws_route_table.public_1.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = module.vpc.public_subnet_ids["public-2"]
  route_table_id = aws_route_table.public_2.id
}

resource "aws_route_table" "private_1" {
  vpc_id = module.vpc.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = module.nat_gateway_public_1.nat_gateway_id
  }
  tags = { Name = "private-1-rt" }
}

resource "aws_route_table" "private_2" {
  vpc_id = module.vpc.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = module.nat_gateway_public_2.nat_gateway_id
  }
  tags = { Name = "private-2-rt" }
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = module.vpc.private_subnet_ids["private-1"]
  route_table_id = aws_route_table.private_1.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = module.vpc.private_subnet_ids["private-2"]
  route_table_id = aws_route_table.private_2.id
}

