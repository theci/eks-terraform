# AIR-platform-terraform

## Requirements

- Terraform 1.5.4
- Docker
- AWS CLI 2.27 (with credentials configured)
- Kustomize 5.4
- kubectl 1.32

## 사전 준비 작업

### 1. AWS 계정 설정
```bash
aws configure
```
다음 정보를 입력하세요:
- AWS Access Key ID
- AWS Secret Access Key
- Default region name: ap-northeast-2
- Default output format: json

### 2. 필수 리소스 사전 생성
- **S3 버킷**: Terraform state 파일 저장용
- **PEM Key**: 키 페어 미리 생성 필요
- **AI 서비스**: Bedrock / OpenAI / VertexAI는 AWS 콘솔에서 사용 신청 진행 후 직접 생성

### 3. 로컬 환경 설정

#### Terraform 설치
```bash
sudo yum install -y yum-utils shadow-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
```

#### kubectl 설치
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl && sudo mv kubectl /usr/local/bin/
kubectl version --client
```

## 배포 순서

### 사전 작업 완료 체크리스트
- [ ] AWS credentials 설정 완료
- [ ] S3 버킷 생성 완료
- [ ] PEM key 생성 완료
- [ ] terraform.tfvars 파일 작성 완료
- [ ] backend.tfvars 파일 작성 완료

### 1단계: 1_network (VPC, 보안 그룹, ACM 인증서)

```bash
cd /home/ec2-user/EKS/air-studio-install-eks/1_terraform/basic/1_network

# Initialize
terraform init -backend-config=../backend.tfvars -var-file=../terraform.tfvars -reconfigure

# Plan (확인)
terraform plan -var-file=../terraform.tfvars -var-file=../backend.tfvars

# Apply (배포)
terraform apply -var-file=../terraform.tfvars -var-file=../backend.tfvars
```

**중요: ACM 인증서 DNS 검증**
1. AWS Console → Certificate Manager에서 인증서 확인
2. DNS 검증을 위한 CNAME 레코드를 도메인 DNS에 추가
3. 인증서가 "Issued" 상태가 될 때까지 대기 (보통 5-30분)

### 2단계: 2_bastion (Bastion Host)

```bash
cd /home/ec2-user/EKS/air-studio-install-eks/1_terraform/basic/2_bastion

terraform init -backend-config=../backend.tfvars -var-file=../terraform.tfvars -reconfigure
terraform plan -var-file=../terraform.tfvars -var-file=../backend.tfvars
terraform apply -var-file=../terraform.tfvars -var-file=../backend.tfvars
```

이 단계는 약 15-20분 소요됩니다.

### 3단계: 3_1_eks (EKS 클러스터)

```bash
cd /home/ec2-user/EKS/air-studio-install-eks/1_terraform/basic/3_1_eks

terraform init -backend-config=../backend.tfvars -var-file=../terraform.tfvars -reconfigure
terraform plan -var-file=../terraform.tfvars -var-file=../backend.tfvars
terraform apply -var-file=../terraform.tfvars -var-file=../backend.tfvars
```

**참고**: admin이라는 IAM Role이 필요하며, Administrator 정책이 필요합니다.

### 4단계: 3_2_eks_resource (EKS 애드온 및 리소스)

```bash
cd /home/ec2-user/EKS/air-studio-install-eks/1_terraform/basic/3_2_eks_resource

# 쉘 스크립트 실행 권한 부여
chmod +x *.sh

terraform init -backend-config=../backend.tfvars -var-file=../terraform.tfvars -reconfigure
terraform plan -var-file=../terraform.tfvars -var-file=../backend.tfvars
terraform apply -var-file=../terraform.tfvars -var-file=../backend.tfvars
```

### 5단계: 4_database (RDS MySQL, OpenSearch)

```bash
cd /home/ec2-user/EKS/air-studio-install-eks/1_terraform/basic/4_database

terraform init -backend-config=../backend.tfvars -var-file=../terraform.tfvars -reconfigure
terraform plan -var-file=../terraform.tfvars -var-file=../backend.tfvars
terraform apply -var-file=../terraform.tfvars -var-file=../backend.tfvars
```

**OpenSearch 서비스 링크 역할이 없는 경우**:
```bash
aws iam create-service-linked-role \
  --aws-service-name opensearchservice.amazonaws.com
```

## 배포 후 작업

### EKS 클러스터 접근 설정

```bash
aws eks --region ap-northeast-2 update-kubeconfig --name air-platform-dev-eks-cluster
kubectl config use-context arn:aws:eks:ap-northeast-2:{account_id}:cluster/air-platform-dev-eks-cluster
kubectl get nodes
```

## 배포 삭제

**주의**: 반드시 역순으로 삭제해야 합니다.

```bash
# 5단계: Database 삭제
cd /home/ec2-user/EKS/air-studio-install-eks/1_terraform/basic/4_database
terraform destroy -var-file=../terraform.tfvars -var-file=../backend.tfvars -auto-approve

# 4단계: EKS Resource 삭제
cd /home/ec2-user/EKS/air-studio-install-eks/1_terraform/basic/3_2_eks_resource
terraform destroy -var-file=../terraform.tfvars -var-file=../backend.tfvars -auto-approve

# 3단계: EKS 클러스터 삭제
cd /home/ec2-user/EKS/air-studio-install-eks/1_terraform/basic/3_1_eks
terraform destroy -var-file=../terraform.tfvars -var-file=../backend.tfvars -auto-approve

# 2단계: Bastion 삭제
cd /home/ec2-user/EKS/air-studio-install-eks/1_terraform/basic/2_bastion
terraform destroy -var-file=../terraform.tfvars -var-file=../backend.tfvars -auto-approve

# 1단계: Network 삭제
cd /home/ec2-user/EKS/air-studio-install-eks/1_terraform/basic/1_network
terraform destroy -var-file=../terraform.tfvars -var-file=../backend.tfvars -auto-approve
```

## ECR (Elastic Container Registry) 설정

### ECR 로그인 (일회성)

```bash
aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin {account_id}.dkr.ecr.ap-northeast-2.amazonaws.com
```

### ECR Credential Helper (권장)

ECR credential helper를 사용하면 AWS 자격 증명을 자동으로 전달하여 `docker login` 또는 `docker logout` 명령을 사용할 필요가 없습니다.

**참고**: Assumed role을 사용하는 경우 환경 변수 `AWS_SDK_LOAD_CONFIG=true`를 설정해야 합니다. 사용 중인 IAM principal에 ECR 권한이 있어야 합니다.

#### 설치 방법

- [Installation Guide](https://github.com/awslabs/amazon-ecr-credential-helper)

#### 설정

`~/.docker/config.json` 파일에 다음 내용을 추가하세요:

```json
{
    "credHelpers": {
        "<aws_account_id>.dkr.ecr.<region>.amazonaws.com": "ecr-login"
    }
}
```

## 주의사항

1. **비밀번호 변경**: terraform.tfvars 파일의 다음 항목을 반드시 변경하세요:
   - `db_password` (기본값: ChangeMe123!)
   - `os_master_user_password` (기본값: ChangeMe123!)

2. **도메인 DNS 설정**: ACM 인증서 검증을 위해 실제 소유한 도메인을 사용해야 합니다.

3. **예상 비용**: 다음 리소스들이 시간당 비용이 발생합니다:
   - EKS 클러스터: ~$0.10/시간
   - EC2 노드 그룹: 인스턴스 타입에 따라
   - RDS MySQL (db.t3.small): ~$0.034/시간
   - NAT Gateway: ~$0.045/시간
   - Bastion EC2 (t3.micro): ~$0.0104/시간

4. **테스트 후 삭제**: 비용 절감을 위해 테스트 후 반드시 리소스를 삭제하세요 (위의 배포 삭제 순서 참조)

