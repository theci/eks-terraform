data "aws_eks_cluster_auth" "default" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

data "aws_eks_cluster" "default" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

provider "kubernetes" {
  token                  = data.aws_eks_cluster_auth.default.token
  host = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)

}


data "aws_caller_identity" "current" {}
output "my_account_id" {
  value = data.aws_caller_identity.current.account_id
}


# ALB Controller


provider "helm" {
  kubernetes {
    token                  = data.aws_eks_cluster_auth.default.token
    host = data.aws_eks_cluster.default.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  }
}

resource "null_resource" "change-kubeconfig" {
  # depends_on = [null_resource.initialization]
  provisioner "local-exec" {
    working_dir = "${path.module}/kubeflow-patches"
    command = "./change_kubeconfig.sh ${data.terraform_remote_state.eks.outputs.cluster_name} ${data.aws_caller_identity.current.account_id} ${var.region} ${var.profile}" #수정
  }
} ##수정은 아니고 설정 ## change_kubeconfig 파일에서 오류 발생 -> 프로필 수정 변경 필요


module "eks-lb-controller" {
  depends_on = [null_resource.change-kubeconfig]
  source  = "DNXLabs/eks-lb-controller/aws"
  version = "0.10.0"
  
  cluster_identity_oidc_issuer     = data.terraform_remote_state.eks.outputs.cluster_oidc_issuer_url
  cluster_identity_oidc_issuer_arn = data.terraform_remote_state.eks.outputs.cluster_identity_oidc_issuer_arn
  cluster_name                     = data.terraform_remote_state.eks.outputs.cluster_name
}

# resource "kubernetes_storage_class" "ebs_csi" {
#   metadata {
#     name = "ebs-csi"
#   }

#   storage_provisioner    = "ebs.csi.aws.com"
#   volume_binding_mode    = "Immediate"
#   reclaim_policy         = "Delete"
#   allow_volume_expansion = true

#   parameters = {
#     type   = "gp3"
#     fsType = "ext4"
#   }
# }

resource "kubernetes_storage_class_v1" "efs_default" {
  depends_on = [null_resource.change-kubeconfig]
  metadata {
    name = "efs-client"
    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "true"
    }
  }

  storage_provisioner = "efs.csi.aws.com"
  reclaim_policy      = "Retain"
  volume_binding_mode = "Immediate"

  parameters = {
    provisioningMode = "efs-ap"
    directoryPerms = "777"
    gidRangeStart =  "1000"
    gidRangeEnd = "2000"
    gid = "1001"
    uid = "1001"
    fileSystemId     = data.terraform_remote_state.eks.outputs.efs_id
    basePath         = var.nfs_server_path
    accessPointId    = data.terraform_remote_state.eks.outputs.efs_id 
  }
}

resource "kubernetes_storage_class_v1" "postgres-sc" {
  depends_on = [null_resource.change-kubeconfig]
  metadata {
    name = "efs-postgres"
  }
  storage_provisioner = "efs.csi.aws.com"
  reclaim_policy      = "Retain"
  volume_binding_mode = "Immediate"
  parameters = {
    provisioningMode = "efs-ap"
    directoryPerms = "777"
    gidRangeStart =  "1000"
    gidRangeEnd = "2000"
    gid = "1001"
    uid = "1001"
    fileSystemId     = data.terraform_remote_state.eks.outputs.efs_id
    basePath         = var.nfs_server_path
    accessPointId    = data.terraform_remote_state.eks.outputs.efs_id  
  }
}


