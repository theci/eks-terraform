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
  default     = "dev"
}

variable "company_ips_for_sg" {
  description = ""
  type        = list(string)
  default     = []

}

variable "cluster_version" {
  description = "Cluster version"
  type        = string
  default     = "dev"
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

variable "db_engine" {
  description = ""
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = ""
  type        = string
  default     = "14"
}

variable "db_instance_class" {
  description = ""
  type        = string
  default     = "db.t3.medium" 
}

variable "db_username" {
  description = ""
  type        = string
  default     = "root"
}

variable "db_password" {
  description = ""
  type        = string
  default     = "Adc123!#"
}

variable "db_use_secret_manager" {
  description = ""
  type        = bool
  default     = false
}

variable "db_secret_manager_rotation" {
  description = ""
  type        = bool
  default     = false
}

variable "db_port" {
  description = ""
  type        = string
  default     = "3306"
}

variable "db_storage_size" {
  description = ""
  type        = string
  default     = "20"
}

variable "db_multi_az" {
  description = ""
  type        = bool
  default     = false
}

variable "db_availability_zone" {
  type        = string
  description = ""
  default     = "ap-northeast-2c"
} #수정

variable "os_engine_version" {
  description = ""
  type        = string
  default     = "14"
}

variable "os_master_user_name" {
  description = ""
  type        = string
  default     = "root"
}

variable "os_master_user_password" {
  description = ""
  type        = string
  default     = "Adc123!#"
}

variable "os_use_secret_manager" {
  description = ""
  type        = bool
  default     = false
} 

variable "os_instance_type" {
  description = ""
  type        = string
  default     = "m5.large.search" 
}

variable "os_instance_count" {
  description = ""  
  type        = number
  default     = 1
}

variable "os_zone_awareness_enabled" {
  description = ""
  type        = bool
  default     = false
}

variable "os_volume_size" {
  description = ""
  type        = number
  default     = 100
}

variable "os_auto_software_update_enabled" {
  description = ""
  type        = bool
  default     = false
}

variable "rds_mysql_name" {
  description = ""
  type        = string
  default     = "air-studio-mysql"
}

variable "opensearch_name" {
  description = ""
  type        = string
  default     = "air-studio-os"
}

variable "os_nori_package_id" {
  description = ""
  type        = string
  default     = "G5688189"
}
