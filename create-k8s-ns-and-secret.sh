#!/bin/bash

# ===========================
# 설정 변수
# ===========================
# DB
DB_SECRET_NAME="<db_secret_name>"  # 생성할 DB K8s Secret 이름 정의
DB_USER="<db_username>"          # platform 계정 정보([데이터베이스 구성] 단계에서 생성한 platform 계정 정보 입력)
DB_PASS="<db_password>"

# OpenSearch
OS_SECRET_NAME="<os_secret_name>"  # 생성할 OpenSearch K8s Secret 이름 정의
OS_USER="<os_username>"           # OpenSearch 계정 정보(OpenSearch 생성 시 입력한 계정 정보 입력)
OS_PASS="<os_password>"

# AWS
# AWS 서비스(S3, Bedrock 등) 이용 시 AWS 자격 증명 필요
AWS_SECRET_NAME="<aws_secret_name>" # 생성할 AWS K8s Secret 이름 정의
AWS_ACCESSKEY="<accesskey>"        # AWS 자격 증명(AWS 서비스(S3 및 Bedrock)에 접근이 가능한 계정 정보 입력)
AWS_SECRETKEY="<secretkey>"

# ===========================
# 1. 네임스페이스 생성
# ===========================
echo "Creating namespace: air-platform"
kubectl create namespace air-platform 2>/dev/null || echo "Namespace air-platform already exists"

# ===========================
# 2. DB 시크릿 생성
# ===========================
echo "Creating DB secret..."
kubectl create secret generic $DB_SECRET_NAME \
  --from-literal=username=$DB_USER \
  --from-literal=password=$DB_PASS \
  -n air-platform \
  --dry-run=client -o yaml | kubectl apply -f -

# ===========================
# 3. OpenSearch 시크릿 생성
# ===========================
echo "Creating OpenSearch secret..."
kubectl create secret generic $OS_SECRET_NAME \
  --from-literal=username=$OS_USER \
  --from-literal=password=$OS_PASS \
  -n air-platform \
  --dry-run=client -o yaml | kubectl apply -f -

# ===========================
# 4. (S3, Bedrock 등 AWS 리소스 사용 시) AWS 시크릿 생성
# ===========================
echo "Creating AWS secret..."
kubectl create secret generic $AWS_SECRET_NAME \
  --from-literal=accesskey=$AWS_ACCESSKEY \
  --from-literal=secretkey=$AWS_SECRETKEY \
  -n air-platform \
  --dry-run=client -o yaml | kubectl apply -f -

echo "All secrets created successfully in namespace air-platform!"
