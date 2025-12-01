resource "aws_launch_template" "this" {
  name          = var.name
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = var.user_data
  security_group_names = null
  vpc_security_group_ids = var.security_group_ids

  tag_specifications {
    resource_type = "instance"
    tags = merge({
      Name = var.name
    }, var.tags)
  }
}
