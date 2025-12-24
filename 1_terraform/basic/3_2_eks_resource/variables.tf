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
  default     = []
  type        = list(string)
}

variable "vpc_cidr" {
  description = "VPC CIDR Range"
  type        = string
  default     = "10.0.0.0/16"
}

variable "tfstate_bucket_name" {
  description = "The Name of backend S3 bucket"
  type        = string
  default     = ""
}

variable "project" {
  description = "The Name of this project"
  type        = string
  default     = ""
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "prd"
}

variable "company_ips_for_sg" {
  description = ""
  type        = list(string)
  default     = []

}

variable "cluster_version" {
  description = "Cluster version"
  type        = string
  default     = "prd"
}



variable "nfs_server_path" {
  description = "nfs_server_path"
  type        = string
  default     = "/data"
}

variable "pem_key_name" {
  description = "node pem key name"
  type        = string
  default     = ""
}

