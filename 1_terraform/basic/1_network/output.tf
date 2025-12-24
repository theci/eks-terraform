output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "eks_route_table_ids" {
  value = module.vpc.private_route_table_ids
}

output "private_subnets_cidr_blocks" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}


output "eks_cluster_security_group_id" {
  value = module.eks_cluster_sg.security_group_id
}


output "bastion_security_group_id" {
  value = module.bastion_sg.security_group_id
}


output "database_subnet_group_name" {
  value = module.vpc.database_subnet_group_name
}

output "db_security_group_id" {
  value = module.db_sg.security_group_id
}

output "database_subnet_ids" {
  value = module.vpc.database_subnets
}