data "terraform_remote_state" "shared" {
  backend = "s3"
  config = {
    bucket         = "terraform-state-bucket-1665571"
    key            = "shared/prod/terraform.tfstate"
    region         = "eu-west-1"
    use_lockfile = true
    encrypt        = true
  }
}

module "launch_template_green" {
  source              = "../../../modules/launch_template"
  name                = "green-template"
  image_id            = "ami-0acd9fd39de089f9b"
  instance_type       = "t3.micro"
  security_group_ids  = [data.terraform_remote_state.shared.outputs.security_group_blue_green_id]
  user_data           = base64encode(file("${path.module}/user_data_green.sh"))
  tags                = { Environment = "green" }
}

module "asg_green" {
  source                  = "../../../modules/asg"
  name                    = "green-asg"
  launch_template_id      = module.launch_template_green.launch_template_id
  vpc_zone_identifier     = [data.terraform_remote_state.shared.outputs.private_subnet_ids["private-1"], data.terraform_remote_state.shared.outputs.private_subnet_ids["private-2"]]
  target_group_arns       = [data.terraform_remote_state.shared.outputs.green_target_group_arn]
  tags                    = { Environment = "green" }
}
