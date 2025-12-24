data "aws_region" "current" {
}

data "aws_eks_cluster_auth" "main" {
  name = data.aws_eks_cluster.test.name
}

provider "kubernetes" {
  host = data.aws_eks_cluster.test.endpoint

  token                  = data.aws_eks_cluster_auth.main.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.test.certificate_authority.0.data)
}

data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}

locals {
  cluster_name = var.eks_cluster_name
  cidr = var.vpc_cidr
  account_id = data.aws_caller_identity.current.account_id
  service_account_name = "terraform-eks-ebs-serviceaccount-${random_id.rng.hex}"
}

resource "random_id" "rng" {
  keepers = {
    first = "${timestamp()}"
  }     
  byte_length = 8
}

resource "aws_efs_file_system" "eks-matilda-filesystem" {
  creation_token = "efs-${local.cluster_name}-token"

  tags = {
    Name = var.efs_name
  }
}

resource "aws_efs_mount_target" "alpha" {
  count = length(data.terraform_remote_state.vpc.outputs.private_subnet_ids)
  file_system_id = aws_efs_file_system.eks-matilda-filesystem.id
  subnet_id      = data.terraform_remote_state.vpc.outputs.private_subnet_ids[count.index] 
  security_groups = ["${data.terraform_remote_state.vpc.outputs.eks_cluster_security_group_id}"]
}

resource "aws_efs_access_point" "eks_matilda_ap" {
  file_system_id = aws_efs_file_system.eks-matilda-filesystem.id

  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    path = var.nfs_server_path
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "755"
    }
  }

  tags = {  
    Name = var.efs_name
  }
}

module "eks" {

  source  = "terraform-aws-modules/eks/aws"
  version = "20.37.1"

  cluster_name    = local.cluster_name
  cluster_version = var.cluster_version

  vpc_id                         = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids                     = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  enable_cluster_creator_admin_permissions = true
  cluster_endpoint_public_access = true
  cluster_endpoint_private_access = true

  create_node_iam_role = true

  node_iam_role_additional_policies = {
    ssm = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  eks_managed_node_group_defaults = {
    disk_size            = "100"
    block_device_mappings = {
      xvda = {
        device_name = "/dev/xvda"
        ebs         = {
          volume_size           = 100
          volume_type           = "gp3"
          iops                  = 3000
          throughput            = 150
          encrypted             = true
          delete_on_termination = true
        }
      }
    }
  }



  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = { resolve_conflicts = "OVERWRITE" }
  }
   
  create_cluster_security_group    = false #수정
  create_node_security_group    = true #수정
  cluster_security_group_id = data.terraform_remote_state.vpc.outputs.eks_cluster_security_group_id
 

  access_entries = var.create_eks_access_entry ? {
    for role_name in var.eks_cluster_access_entries : role_name => {
      principal_arn = "arn:aws:iam::${local.account_id}:role/${role_name}"

      policy_associations = {
        example = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type       = "cluster"
          }
        }
      }
    }
  } : {}

  

  eks_managed_node_groups = {

    one = {
      name = var.mgmt_node_group_name
      instance_types = [var.mgmt_node_group_instance_type]

      desired_size = var.mgmt_node_group_desired_size
      min_size     = 0
      max_size     = max(1, var.mgmt_node_group_desired_size)

      

      schedules = var.mgmt_node_group_onoff ? {
        up = {
            scheduled_action_name = "scale-up-weekday"
            desired_size           = var.mgmt_node_group_desired_size
            min_size               = var.mgmt_node_group_desired_size
            max_size               = var.mgmt_node_group_desired_size
            recurrence             = var.scheduler_up_time
            time_zone               = "Asia/Seoul"
          }
        down = {
          scheduled_action_name = "scale-down-weekday"
          desired_size           = 0
          min_size               = 0
          max_size               = 0
          recurrence             = var.scheduler_down_time
          time_zone               = "Asia/Seoul"
        }

      } : {}
      key_name = var.pem_key_name
      iam_role_additional_policies = var.eks_node_group_iam_role_additional_policies


    }

    gpu = {     # GPU 노드 그룹 추가 
      name           = var.gpu_node_group_name
      instance_types = [var.gpu_node_group_instance_type]           # GPU 인스턴스
      desired_size   = var.gpu_node_group_desired_size
      min_size       = 0
      max_size       = max(1, var.gpu_node_group_desired_size)

      ami_type = var.gpu_node_group_ami_type

      # 스케줄링 (선택)
      schedules = var.gpu_node_group_onoff ? {
        up = {
          scheduled_action_name = "scale-up-weekday"
          desired_size = var.gpu_node_group_desired_size
          min_size     = var.gpu_node_group_desired_size
          max_size     = var.gpu_node_group_desired_size
          recurrence   = var.scheduler_up_time
          time_zone    = "Asia/Seoul"
        }
        down = {
          scheduled_action_name = "scale-down-weekday"
          desired_size = 0
          min_size     = 0
          max_size     = 0
          recurrence   = var.scheduler_down_time
          time_zone    = "Asia/Seoul"
        }
      } : {}

      key_name = var.pem_key_name
      iam_role_additional_policies = var.eks_node_group_iam_role_additional_policies

      labels = {
        role = "gpu"
      }
    }
  }
}



# https://aws.amazon.com/blogs/containers/amazon-ebs-csi-driver-is-now-generally-available-in-amazon-eks-add-ons/ 
data "aws_iam_policy" "ebs_csi_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

module "irsa-ebs-csi" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "4.7.0"

  create_role                   = true
  role_name                     = "AmazonEKSTFEBSCSIRole-${module.eks.cluster_name}"
  provider_url                  = module.eks.oidc_provider
  role_policy_arns              = [data.aws_iam_policy.ebs_csi_policy.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
}

resource "aws_eks_addon" "ebs-csi" {
  cluster_name             = module.eks.cluster_name
  addon_name               = "aws-ebs-csi-driver"
  service_account_role_arn = module.irsa-ebs-csi.iam_role_arn
  tags = {
    "eks_addon" = "ebs-csi"
    "terraform" = "true"
  }
}

data "aws_eks_cluster" "test" {
  name = module.eks.cluster_name
  depends_on = [module.eks.cluster_name]
}

data "aws_eks_cluster_auth" "test" {
  name = module.eks.cluster_name
  depends_on = [module.eks.cluster_name]
}

data "aws_iam_policy" "efs_csi_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
}

module "irsa-efs-csi" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "4.7.0"

  create_role                   = true
  role_name                     = "AmazonEKSTFEFSCSIRole-${module.eks.cluster_name}"
  provider_url                  = module.eks.oidc_provider
  role_policy_arns              = [data.aws_iam_policy.efs_csi_policy.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:efs-csi-controller-sa"]
}

resource "aws_eks_addon" "efs-csi" {
  cluster_name             = module.eks.cluster_name
  addon_name               = "aws-efs-csi-driver"
  service_account_role_arn = module.irsa-efs-csi.iam_role_arn
  tags = {
    "eks_addon" = "efs-csi"
    "terraform" = "true"
  }
}



module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "2.4.0"
  for_each = toset(var.ecr_names)

  repository_name = "${each.value}"

  repository_image_tag_mutability = "MUTABLE"

  repository_read_write_access_arns = [ module.eks.cluster_iam_role_arn]
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"]
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  
}



