locals {
  major_engine_version = join(".", slice(split(".", var.db_engine_version), 0, 2))
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.0"

  identifier = var.rds_mysql_name

  engine            = var.db_engine
  engine_version    = var.db_engine_version
  family            = "${var.db_engine}${local.major_engine_version}"
  major_engine_version = local.major_engine_version
  instance_class    = var.db_instance_class
  allocated_storage = var.db_storage_size

  username = var.db_username
  password = var.db_password
  port     = var.db_port

  manage_master_user_password = var.db_use_secret_manager
  manage_master_user_password_rotation = var.db_secret_manager_rotation

  multi_az               = var.db_multi_az
  availability_zone    = var.db_multi_az == false ? var.db_availability_zone : null #여기수정 #단중화용도 #ap-northeast-2c 지정
  db_subnet_group_name   = data.terraform_remote_state.vpc.outputs.database_subnet_group_name
  subnet_ids             = data.terraform_remote_state.vpc.outputs.database_subnet_ids
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.db_security_group_id]

  publicly_accessible = false

  parameters = [
    {
      name  = "log_bin_trust_function_creators"
      value = "1"
    },
    {
      name = "max_connections"
      value = "{DBInstanceClassMemory/8000000}"
    },
    {
      name = "time_zone"
      value = "Asia/Seoul"
    }
  ]

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["error", "general", "slowquery"]
  create_cloudwatch_log_group     = true

  backup_retention_period = 1
  skip_final_snapshot     = true
  deletion_protection     = true ####수정수정 ## destroy 때문에
  # deletion_protection     = false

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60
  monitoring_role_name                  = "example-monitoring-role-name"
  monitoring_role_use_name_prefix       = true
  monitoring_role_description           = "Description for monitoring role"


}


# resource "aws_iam_service_linked_role" "opensearch" {
#   aws_service_name = "opensearchservice.amazonaws.com"
# } # 여기수정이슈 에러나서 주석 해제하고 다시 돌리기 -> 또 이슈 -> 주석 설정하고 다시 돌리기 -> 잘 됨

module "opensearch" {
  # depends_on = [aws_iam_service_linked_role.opensearch] # 여기수정이슈 에러나서 주석 해제하고 다시 돌리기 -> 또 이슈 -> 주석 설정하고 다시 돌리기 -> 잘 됨
  source  = "terraform-aws-modules/opensearch/aws"
  version = "1.7.0"

  domain_name = var.opensearch_name  # 예: myproject-dev-os

  engine_version = var.os_engine_version

  cluster_config = {
    instance_type  = var.os_instance_type
    instance_count = var.os_instance_count
    zone_awareness_enabled = var.os_zone_awareness_enabled
    dedicated_master_enabled = false
  }

  security_group_rules = {
    opensearch_9200 = {
      type                     = "ingress"
      ip_protocol              = "tcp"
      from_port                = 9200
      to_port                  = 9200
      cidr_ipv4               = var.company_ips_for_sg[0]  # 첫 번째 IP만 테스트
      description             = "OpenSearch port 9200"
    }
    opensearch_443 = {
      type                     = "ingress" 
      ip_protocol              = "tcp"
      from_port                = 443
      to_port                  = 443
      cidr_ipv4               = var.vpc_cidr  
      description             = "OpenSearch HTTPS ingress for VPC"
    }
    opensearch_vcp = {
      type                     = "ingress"
      ip_protocol              = "tcp"
      from_port                = 9200
      to_port                  = 9200
      cidr_ipv4               = var.vpc_cidr
      description             = "OpenSearch port 9200 from VPC"
    }
  }

  advanced_security_options = {
  enabled                        = true
  internal_user_database_enabled = true
  master_user_options = {
    master_user_name     = var.os_master_user_name
    master_user_password = var.os_master_user_password
    }
  }

  access_policy_statements = [
    {
      effect = "Allow"

      principals = [{
        type        = "*"
        identifiers = ["*"]
      }]

      actions = ["es:*"]

      resources = ["*"]
    }
  ]



  ebs_options = {
    ebs_enabled = true
    volume_size = var.os_volume_size  # GB
    volume_type = "gp3"
  }

  encrypt_at_rest = {
    enabled = true
  }

  node_to_node_encryption = {
    enabled = true
  }

  domain_endpoint_options = {
    enforce_https = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  vpc_options = {
    # subnet_ids         = slice(data.terraform_remote_state.vpc.outputs.database_subnet_ids, 0, 1)
    subnet_ids         = slice(data.terraform_remote_state.vpc.outputs.database_subnet_ids, 0, 1) #여기수정필요 #ap-northeast-2c 지정
    security_group_ids = [data.terraform_remote_state.vpc.outputs.db_security_group_id]
  }

  software_update_options = {
    auto_software_update_enabled = var.os_auto_software_update_enabled
  }

  auto_tune_options = {
    desired_state = "DISABLED"
  }

  # 타임아웃 설정 - 패키지 설치 시간을 고려하여 늘림
  timeouts = {
    create = "25m"
    update = "25m" 
    delete = "25m"
  }

  tags = {
    Name    = "${var.project}-${var.env}-opensearch"
    Project = var.project
    Env     = var.env
  }
}

# OpenSearch 도메인이 활성화될 때까지 대기
resource "null_resource" "wait_for_opensearch_ready" {
  provisioner "local-exec" {
    command = <<EOT
#!/bin/bash
set -e

DOMAIN_NAME="${var.opensearch_name}"
REGION="${var.region}"

echo "Waiting for OpenSearch domain to become active..."

for i in {1..30}; do
  STATUS=$(aws opensearch describe-domain \
    --domain-name "$DOMAIN_NAME" \
    --region "$REGION" \
    --query 'DomainStatus.Processing' \
    --output text)

  if [ "$STATUS" = "False" ]; then
    echo "Domain is now active"
    exit 0
  fi

  echo "Waiting... Current status: Processing=$STATUS"
  sleep 20
done

echo "Domain did not become active in expected time"
exit 1
EOT
  }

  triggers = {
    opensearch_domain_id = module.opensearch.domain_id
  }

  depends_on = [module.opensearch]
}

# Nori 분석기 패키지 동적 연결 - 호환 가능한 패키지 자동 검색
resource "null_resource" "attach_nori_plugin" {
  provisioner "local-exec" {
    command = <<EOT
#!/bin/bash
set -e

REGION="${var.region}"
DOMAIN_NAME="${var.opensearch_name}"

# 이미 연결된 패키지 확인
EXISTING_PACKAGES=$(aws opensearch list-packages-for-domain \
  --domain-name "$DOMAIN_NAME" \
  --region "$REGION" \
  --query 'DomainPackageDetailsList[?PackageName==`analysis-nori`].PackageID' \
  --output text 2>/dev/null || echo "")

if [ -n "$EXISTING_PACKAGES" ]; then
  echo "analysis-nori package is already associated with domain"
  exit 0
fi

# nori 패키지 목록 가져오기
PACKAGE_IDS=$(aws opensearch describe-packages \
  --region "$REGION" \
  --filters '[{"Name": "PackageType", "Value": ["ZIP-PLUGIN"]}, {"Name": "PackageName", "Value": ["analysis-nori"]}]' \
  --query 'PackageDetailsList[].PackageID' \
  --output text)

if [ -z "$PACKAGE_IDS" ]; then
  echo "No analysis-nori packages found"
  exit 1
fi

# 하나씩 연결 시도
for PACKAGE_ID in $PACKAGE_IDS; do
  echo "Trying package: $PACKAGE_ID"
  if aws opensearch associate-package \
    --package-id "$PACKAGE_ID" \
    --domain-name "$DOMAIN_NAME" \
    --region "$REGION" 2>/dev/null; then
    echo "Successfully associated package: $PACKAGE_ID"
    exit 0
  else
    echo "Failed to associate (incompatible): $PACKAGE_ID"
  fi
done

echo "Could not find compatible analysis-nori package"
exit 1
EOT
  }

  triggers = {
    opensearch_domain_id = module.opensearch.domain_id
  }

  depends_on = [null_resource.wait_for_opensearch_ready]
}