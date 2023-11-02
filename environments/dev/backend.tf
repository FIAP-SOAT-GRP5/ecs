terraform {
  backend "s3" {
    bucket = "terraform-tfstate-fiap-vianna"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
