terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-1665571"
    key            = "green/prod/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "mi-tf-lock-table"
    encrypt        = true
  }
}