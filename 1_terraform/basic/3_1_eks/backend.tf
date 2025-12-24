terraform {
  backend "s3" {
      key            = "3_1_eks/terraform.tfstate"
      encrypt        = true
      bucket = var.bucket #수정
      region         = var.region #수정
      profile = var.profile ##수정
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.tfstate_bucket_name
    region = var.region
    key    = "1_network/terraform.tfstate"
    profile = var.profile ##수정
  }
}

