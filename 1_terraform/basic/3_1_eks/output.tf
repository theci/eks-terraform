output "cluster_oidc_issuer_url" {
  value = module.eks.cluster_oidc_issuer_url
}

output "cluster_name" {
    value = module.eks.cluster_name
}

output "efs_dns_name" {
  value = aws_efs_file_system.eks-matilda-filesystem.dns_name
}

output "efs_id" {
  value = aws_efs_file_system.eks-matilda-filesystem.id
}

output "efs_ap_id" {
  value = aws_efs_access_point.eks_matilda_ap.id
}

output "cluster_identity_oidc_issuer_arn" {
  value = module.eks.oidc_provider_arn
}