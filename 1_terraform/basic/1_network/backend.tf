terraform {
  backend "s3" {
      key            = "1_network/terraform.tfstate"
      encrypt        = true
      bucket = var.bucket #수정
      region         = var.region #수정
      profile        = var.profile ##수정
  }
}
