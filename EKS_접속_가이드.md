# EKS 접속 가이드

## 1. PEM 키 위치 및 bastion 접속
```bash
/home/ec2-user/air-platform-key.pem
```

## 2. aws cli v2 설치
 sudo yum remove awscli -y

  # AWS CLI v2 다운로드 및 설치
  cd /tmp
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install

  # 설치 확인
  /usr/local/bin/aws --version

  # 심볼릭 링크 업데이트 (필요시)
  sudo ln -sf /usr/local/bin/aws /usr/bin/aws

## 3. kubectl 설치

### kubectl 설치 (Amazon Linux 2023)
```bash
# kubectl 바이너리 다운로드
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# 실행 권한 부여 & PATH에 추가
chmod +x ./kubectl
sudo mv kubectl /usr/local/bin/kubectl
# 설치 확인
kubectl version --client
```

### PATH 영구 추가 (선택사항)
```bash
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

## 4. EKS 클러스터 접속 설정

### kubeconfig 업데이트
```bash
aws eks --region ap-northeast-2 update-kubeconfig --name air-platform-eks-cluster
```

### 단축키 설정
echo 'alias k=kubectl' >> ~/.bashrc
source ~/.bashrc



### 클러스터 연결 확인
```bash
kubectl get nodes
kubectl get pods -A
kubectl cluster-info
```

## 5. 주요 kubectl 명령어

### 노드 확인
```bash
kubectl get nodes -o wide
```

### 네임스페이스 확인
```bash
kubectl get namespaces
```

### 모든 리소스 확인
```bash
kubectl get all -A
```

### 특정 네임스페이스의 Pod 확인
```bash
kubectl get pods -n kube-system
```

### Pod 로그 확인
```bash
kubectl logs <pod-name> -n <namespace>
```

### Pod 내부 접속
```bash
kubectl exec -it <pod-name> -n <namespace> -- /bin/bash
```

## 6. Bastion 호스트 접속 (필요시)

### Bastion Public IP 확인
```bash
cd /home/ec2-user/AIR-platform-terraform-eks/dev/4_bastion
terraform output
```

### SSH 접속
```bash
ssh -i /home/ec2-user/air-platform-dev-key.pem ec2-user@<BASTION_PUBLIC_IP>
```

## 7. ECR 로그인 (컨테이너 이미지 푸시 시)

```bash
aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 443170140486.dkr.ecr.ap-northeast-2.amazonaws.com
```

## 8. 리소스 확인

### EKS 클러스터 정보
```bash
aws eks describe-cluster --name air-platform-dev-eks-cluster --region ap-northeast-2
```

### 노드 그룹 정보
```bash
aws eks list-nodegroups --cluster-name air-platform-dev-eks-cluster --region ap-northeast-2
```

### RDS 엔드포인트 확인
```bash
cd /home/ec2-user/AIR-platform-terraform-eks/dev/3_database
terraform output rds_endpoint
```

### OpenSearch 엔드포인트 확인
```bash
cd /home/ec2-user/AIR-platform-terraform-eks/dev/3_database
terraform output opensearch_endpoint
```

## 9. 배포된 리소스 요약

현재 배포된 리소스:
- VPC 및 네트워크 (서브넷, NAT Gateway, 보안 그룹)
- EKS 클러스터 (버전 1.31)
- EKS 노드 그룹
- EKS 애드온 (EBS CSI, EFS CSI 등)
- RDS MySQL 데이터베이스
- OpenSearch
- Bastion 호스트

## 10. 다음 단계

1. kubectl 설치
2. EKS 클러스터 접속 설정
3. 애플리케이션 배포 (Kubernetes manifest 또는 Helm)
4. 모니터링 및 로깅 설정 (선택사항)

## 주의사항

- PEM 키 파일 권한: `chmod 400 /home/ec2-user/air-platform-dev-key.pem`
- 데이터베이스 비밀번호는 반드시 변경하세요
- 테스트 후 리소스 삭제 시 비용이 계속 발생하므로 주의하세요
