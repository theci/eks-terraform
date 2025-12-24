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
  default     = "dev"
}
variable "workbench_instance_type" {
  description = ""
  default = "t3.micro" 
  type = string
}

variable "pem_key_name" {
  description = ""
  default = ""
  type = string
}



variable "tags" {
  description = ""
  default = {}
  type = map(string)
}

variable "workbench_iam_role_name" {
  description = ""
  default = "bastion-ssm-role"
  type = string
}


variable "create_iam_instance_profile" {
  description = ""
  default = true
  type = bool
}

variable "workbench_iam_role_policies" {
  description = ""
  default = {
    ssm           = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
  type = map(string)
}


variable "workbench_volume_type" {
  description = ""
  default = "gp3"
  type = string
}

variable "workbench_volume_size" {
  description = ""
  default = 8
  type = number
}

variable "workbench_instance_count" {
  description = ""
  default = 1
  type = number
}

variable "workbench_instance_name" {
  description = ""
  default = "workbench"
  type = string
}

variable "workbench_use_ami" {
  description = ""
  default = false
  type = bool
}

variable "workbench_instance_ami" {
  description = ""
  default = ""
  type = string
}