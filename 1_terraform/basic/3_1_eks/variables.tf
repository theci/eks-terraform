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

variable "ecr_names" {
  description = ""
  type        = list(string)
  default     = []
}

variable "jenkins_account_id" {
  description = "jenkins account id"
  type        = string
  default     = ""
}

variable "eks_node_group_iam_role_additional_policies" {
  description = "iam_role_additional_policies"
  default = {
    ssm           = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    ecr = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  }
  type = map(string)
}

variable "scheduler_up_time" {
  description = "scheduler_up_time"
  type        = string
  default     = "0 7 * * 1-5"
}

variable "scheduler_down_time" {
  description = "scheduler_down_time"
  type        = string
  default     = "0 20 * * 1-5"
}

variable "mgmt_node_group_instance_type" {
  description = "mgmt_node_group_instance_type"
  type        = string
  default     = "t3.xlarge"
} 

variable "mgmt_node_group_desired_size" {
  description = "mgmt_node_group_desired_size"
  type        = number
  default     = 2
}

variable "mgmt_node_group_onoff" {
  description = "mgmt_node_group_onoff"
  type        = bool
  default     = true
} 

variable "mgmt_node_group_name" {
  description = "mgmt_node_group_name"
  type        = string
  default     = "node-group-platform"
}

variable "gpu_node_group_onoff" {  
  description = "gpu_node_group_onoff"
  type        = bool
  default     = true
}

variable "gpu_node_group_name" {  
  description = "gpu_node_group_name"
  type        = string
  default     = "node-group-gpu"
}

variable "gpu_node_group_instance_type" {   
  description = "gpu_node_group_instance_type"
  type        = string
  default     = "g6.2xlarge"
}

variable "gpu_node_group_desired_size" {   
  description = "gpu_node_group_desired_size"
  type        = number
  default     = 0
}

variable "gpu_node_group_ami_type" {  
  description = "gpu_node_group_ami_type"
  type        = string
  default     = "AL2023_x86_64_NVIDIA"
}

variable "eks_cluster_name" {
  type = string
  default = "eks-cluster"
}

variable "efs_name" {
  type = string
  default = "air-studio-efs"
}

variable "eks_cluster_access_entries" {
  type = list(string)
  default = []
}

variable "create_eks_access_entry" {
  type = bool
  default = false
}
