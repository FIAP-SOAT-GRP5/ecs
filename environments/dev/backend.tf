terraform {
  backend "s3" {
    bucket = "terraform-tfstate-fiap"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}