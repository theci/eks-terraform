# VPC


# locals {
#   # /25 → newbits = 5 (2^5 = 32개 중 0~3 사용)
#   public_subnet_1 = cidrsubnet(var.vpc_cidr, 5, 0)
#   public_subnet_2 = cidrsubnet(var.vpc_cidr, 5, 1)
#   database_subnet_1 = cidrsubnet(var.vpc_cidr, 5, 2)
#   database_subnet_2 = cidrsubnet(var.vpc_cidr, 5, 3)

#   # /22 → newbits = 2 (2^2 = 4개 중 0~1 사용)
#   private_subnet_1 = cidrsubnet(var.vpc_cidr, 2, 2)
#   private_subnet_2 = cidrsubnet(var.vpc_cidr, 2, 3)
# } #기존

locals {
  # Public 서브넷 /27 (30개 IP)
  public_subnet_1 = cidrsubnet(var.vpc_cidr, 3, 0)    # 10.43.0.0/27
  public_subnet_2 = cidrsubnet(var.vpc_cidr, 3, 1)    # 10.43.0.32/27
  
  # Private 서브넷 /26 (62개 IP) - EKS용
  private_subnet_1 = cidrsubnet(var.vpc_cidr, 2, 1)   # 10.43.0.64/26
  private_subnet_2 = cidrsubnet(var.vpc_cidr, 2, 2)   # 10.43.0.128/26
  
  # Database 서브넷 /27 (30개 IP)
  database_subnet_1 = cidrsubnet(var.vpc_cidr, 3, 6)  # 10.43.0.192/27
  database_subnet_2 = cidrsubnet(var.vpc_cidr, 3, 7)  # 10.43.0.224/27
} #여기 변경 수정 



module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name = "${var.project}-${var.env}-vpc"
  azs  = var.azs
  cidr = var.vpc_cidr


  # Enable DNS resolution
  enable_dns_support   = true

  # Enable DNS hostnames 
  enable_dns_hostnames = true

  # NAT게이트웨이를 생성
  enable_nat_gateway = true
  # NAT게이트웨이를 1개만 생성합니다.
  single_nat_gateway = true

  #RDS를 위한 서브넷 그룹
  create_database_subnet_group           = true
  create_database_subnet_route_table     = true


  public_subnets = [local.public_subnet_1,local.public_subnet_2]
  # public_subnet_names = [for index in range(length(var.azs)) : var.public_subnet_names + substr(var.azs[index], -1, -1)] #오류
  public_subnet_names = [
    for index in range(length(var.azs)) :
    "${var.public_subnet_names}${substr(var.azs[index], -1, 1)}"
  ] #수정
  public_route_table_tags = { Name = var.public_route_table_name}


  private_subnets = [local.private_subnet_1,local.private_subnet_2]
  # private_subnet_names = [for index in range(length(var.azs)) : var.private_subnet_names + substr(var.azs[index], -1, -1)] #오류
  private_subnet_names = [
    for index in range(length(var.azs)) :
    "${var.private_subnet_names}${substr(var.azs[index], -1, 1)}"
  ] #수정
  private_route_table_tags = { Name = var.private_route_table_name}


  database_subnets = [local.database_subnet_1,local.database_subnet_2]
  # database_subnet_names = [for index in range(length(var.azs)) : var.database_subnet_names + substr(var.azs[index], -1, -1)] #오류
  database_subnet_names = [
    for index in range(length(var.azs)) :
    "${var.database_subnet_names}${substr(var.azs[index], -1, 1)}"
  ] #수정
  database_route_table_tags = { Name = var.database_route_table_name}

                                         
#   intra_subnets = [for index in range(length(var.azs)): cidrsubnet(var.vpc_cidr, 6, index + length(var.azs)*3)]
#   intra_subnet_names = [for index in range(length(var.azs)) : "${var.project}-${var.env}-eni-pri-sub-${substr(var.azs[index], -1, -1)}"]
#   intra_route_table_tags = { Name = "${var.project}-${var.env}-eni-prisub-rt"}


  igw_tags = { Name = var.igw_name }
  nat_gateway_tags = { Name = var.nat_gateway_name }

  tags = {
    Terraform = "true"
    Environment = var.env
  }


  #eks - alb ingress controller 를 위한 태깅

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }



}



# Security Group
##  보안 그룹은 일단 만들어 두고 추후 리소스에 추가

## eks cluster sg
module "eks_cluster_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"


  name        = var.eks_cluster_sg_name
  description = "Security group for EKS cluster"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      rule        = "all-all"
      description = "Allow all traffic from VPC"
      cidr_blocks = var.vpc_cidr
    }
  ]
  ingress_with_self = [
    {
      rule        = "all-all"
      description = "Allow all from self"
    }
  ]
  egress_rules        = ["all-all"]

  tags = {
    Name = var.eks_cluster_sg_name
  }


}


## efs sg

module "efs_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"


  name        = var.efs_sg_name
  description = "Allow efs csi inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 2049
      to_port     = 2049
      protocol    = "tcp"
      description = "TLS from VPC"
      cidr_blocks = var.vpc_cidr
    }
  ]

  egress_rules        = ["all-all"]

  tags = {
    Name = var.efs_sg_name
  }


}



## 회사 IP 추가 함
module "bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"


  name        = var.bastion_sg_name
  description = "Security group for bastion"
  vpc_id      = module.vpc.vpc_id

  # ingress_with_cidr_blocks = [
  #   for cidr in var.company_ips_for_sg : {
  #     from_port   = 22
  #     to_port     = 22
  #     protocol    = "tcp"
  #     description = "Allow 22 traffic from Company IPs"
  #     cidr_blocks = cidr
  #   }
  # ]
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow 22 traffic from Company IPs"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  ingress_with_self = [
    {
      rule        = "all-all"
      description = "Allow all from self"
    }
  ]

  egress_rules        = ["all-all"]

  tags = {
    Name = var.bastion_sg_name
  }

}

# DB mysql sg
module "db_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name        = var.db_sg_name
  description = "Security group for mysql with custom ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "Allow 3306 traffic from VPC cidr"
      cidr_blocks = var.vpc_cidr
    }
  ]
  ingress_with_source_security_group_id = [
    {
      rule                     = "all-all"
      source_security_group_id = module.bastion_sg.security_group_id
    },
    {
      rule                     = "all-all"
      source_security_group_id = module.eks_cluster_sg.security_group_id
    },
  ]
  ingress_with_self = [
    {
      rule        = "all-all"
      description = "Allow all from self"
    }
  ]


  egress_rules        = ["all-all"]

  tags = {
    Name = var.db_sg_name
  }

}


# ACM #인증서 없으므로 주석처리로 수정

# resource "aws_acm_certificate" "aisp_wildcard" {
#   domain_name               = "*.dev.aisp-demo.megaone.com"
#   subject_alternative_names = ["dev.aisp-demo.megaone.com"]
#   validation_method         = "DNS"

#   tags = {
#     Name = "${var.project}-${var.env}-wildcard"
#     Environment = var.env
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

####################### 이거 있으면 오류남 #### 수정
# resource "aws_acm_certificate" "air_wildcard" {
#   domain_name               = "*.${var.platform_domain}"
#   subject_alternative_names = [var.platform_domain]
#   validation_method         = "DNS"

#   tags = {
#     Name = "${var.project}-${var.env}-wildcard"
#     Environment = var.env
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }
#######################
