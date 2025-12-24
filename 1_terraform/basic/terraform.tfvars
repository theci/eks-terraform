# Backend 
tfstate_bucket_name = "air-platform-tfstate-721747834183"


# Environment
env = "prd"
project = "air-studio"
profile = "default" #환경 변수로 지정된 AWS 자격 증명이 있으면 profile 설정보다 우선 적용

# default 값은 서울리전, 리전별 모든 가용역역
region = "ap-northeast-2"
azs = ["ap-northeast-2a","ap-northeast-2c"]

# VPC CIDR 적정 /23, 
vpc_cidr     = "10.0.0.0/16" 

# VPC
public_subnet_names = "pub-subnet"
private_subnet_names = "pri-subnet"
database_subnet_names = "db-subnet"
public_route_table_name = "pub-route-table"
private_route_table_name = "pri-route-table"
database_route_table_name = "db-route-table"

# VPC
igw_name = "igw"
nat_gateway_name = "nat-gateway"
eks_cluster_sg_name = "eks-cluster-sg"
efs_sg_name = "efs-sg"
bastion_sg_name = "bastion-sg"
db_sg_name = "db-sg"

#ips for sg
company_ips_for_sg = ["59.10.176.51/32"]

# node pemkey
pem_key_name = "air-platform-key" 


# mysql
rds_mysql_name = "air-platform-mysql"
db_engine = "mysql"
db_engine_version = "8.0.43"
# db_instance_class = "db.m5.large"
db_instance_class = "db.t3.medium" 
db_username = "root"
db_password = "Adc123!#"
db_port = "3306"
# db_storage_size = "200" #db 볼륨 사이즈
db_storage_size = "20" 
# db_multi_az = true  
db_multi_az = false #RDS DB 단중화
db_availability_zone = "ap-northeast-2c" #단일 AZ 배포시
db_use_secret_manager = false
db_secret_manager_rotation = false

#opensearch
opensearch_name = "air-platform-os"
os_engine_version = "OpenSearch_2.19"
os_master_user_name = "airstudio"    # Platform(AIR Studio)에서 접근 시 사용하는 계정 이름
os_master_user_password = "Adc123!#"
os_instance_type = "m5.large.search"
os_instance_count = 1 
os_zone_awareness_enabled = false
os_dedicated_master_enabled = false
# os_volume_size = 200 #opensearch 볼륨사이즈
os_volume_size = 20 #opensearch 볼륨사이즈 단중화 구성
os_auto_software_update_enabled = false
# os_nori_package_id = "G145040926"

# workbench
# bastion ec2 workbench 최소 필요 사양 : core 2 / mem 8GB / volume 100GB
workbench_instance_type = "t3.large"
workbench_instance_count = "1"
workbench_instance_name = "workbench"
workbench_volume_type = "gp3"
workbench_volume_size = "100" #bastion ec2 workbench 볼륨사이즈

create_iam_instance_profile = true
workbench_iam_role_name = "bastion-ssm-role"
workbench_iam_role_policies = {
    ssm = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    ecr = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser",
    bedrock = "arn:aws:iam::aws:policy/AmazonBedrockFullAccess",
    s3 = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    eks = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# 생성한 AMI 사용하는 경우
# workbench_use_ami = true
# workbench_instance_ami = "ami-00000000000000000"





# ECR names

ecr_names = [ 
    "sample-ecr",
    "air-studio-app",
    "air-studio-api",
    "mcp-conflueuce"

]


############ for platform addons #########################################

eks_cluster_name = "air-platform-eks-cluster"
cluster_version = "1.33" #버전 1.32 -> 1.33 업그레이드
mgmt_node_group_name = "node-group-platform"
mgmt_node_group_instance_type = "t3.xlarge"
mgmt_node_group_desired_size = "2" 
gpu_node_group_name = "node-group-gpu"
gpu_node_group_instance_type = "g6.xlarge"
gpu_node_group_desired_size = "0"
gpu_node_group_ami_type = "AL2023_x86_64_NVIDIA"
mgmt_node_group_onoff = true
gpu_node_group_onoff = true
scheduler_up_time = "0 7 * * 1"
scheduler_down_time = "0 0 * * 6"
eks_cluster_access_entries = ["bastion-ssm-role"] #미리 role 생성 필요
create_eks_access_entry = true

eks_node_group_iam_role_additional_policies = {
    AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy",
    ssm = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    ecr = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser",
    bedrock = "arn:aws:iam::aws:policy/AmazonBedrockFullAccess",
    s3 = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}


storage_class_name = "efs-client"
efs_name = "air-studio-efs"
#storage_class_provisioner = "cluster.local/nfs-storage-nfs-subdir-external-provisioner"
storage_class_provisioner = "efs.csi.aws.com"


platform_domain = "prd.air-platform.com"  #air-studio.platform_domain


#############################################################################
