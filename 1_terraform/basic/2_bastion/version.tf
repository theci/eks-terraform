provider "aws" {
  region = var.region
  profile = var.profile ##수정수정 #### 
  default_tags {
    tags = {
      project   = var.project
      env = var.env
    }
  }
}

terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.47"
    }
  }
}

