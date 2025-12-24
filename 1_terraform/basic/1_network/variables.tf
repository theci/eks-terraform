# variables.tf
variable "region" {
  default = "ap-northeast-2"
}

variable "profile" {
  default = ""
  type        = string
} ####수정

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  default = []
  type = list(string)
}


variable "vpc_cidr" {
  description = "VPC CIDR Range"
  type = string
  default = "10.0.0.0/16" 
} 

variable "tfstate_bucket_name" {
  description = "The Name of backend S3 bucket"
  type = string
  default = ""
}

variable "project" {
  description = "The Name of this project"
  type = string
  default = ""
}

variable "env" {
  description = "Environment"
  type = string
  default = "dev"
}

variable "company_ips_for_sg" {
  description = ""
  type        = list(string)
  default     = []

}

variable "platform_domain" {
  description = "domain"
  type = string
  default = "example.com"
}

variable "public_subnet_names" {
  type = string
}

variable "private_subnet_names" {
  type = string
}

variable "database_subnet_names" {
  type = string
}

variable "public_route_table_name" {
  type = string
}

variable "private_route_table_name" {
  type = string
}

variable "database_route_table_name" {
  type = string
}


variable "igw_name" {
  type = string
}

variable "nat_gateway_name" {
  type = string
}

variable "eks_cluster_name" {
  type = string
}

variable "eks_cluster_sg_name" {
  type = string
}

variable "efs_sg_name" {
  type = string
}

variable "bastion_sg_name" {
  type = string
}

variable "db_sg_name" {
  type = string
}
