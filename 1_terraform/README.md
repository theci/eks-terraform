# AIR-platform-terraform

## requirement 

terraform 1.5.4

docker 

aws cli(credential 설정) 2.27

kustomize 5.4

kubectl 1.32

## 계정 사전 생성

- tfstate 용 s3 버킷
- pem key (키 페어 미리 생성 필요!)
- bedrock / OpenAI / VertexAI 는 콘솔에서 사용신청 진행 후 직접 생성


## 배포시 환경별 tfvars 와 backend.tf 경로 수정 필요


## 배포 방법

terraform.tfvars 와 backend.tfvars 환경에 맞게 수정

각 폴더 순서 별로 접근하여 순차 배포

~~~bash
terraform init -backend-config=../backend.tfvars -var-file=../terraform.tfvars -reconfigure
terraform plan -var-file=../terraform.tfvars -var-file=../backend.tfvars # test
# terraform apply -var-file=../terraform.tfvars -var-file=../backend.tfvars -auto-approve #수정
terraform apply -var-file=../terraform.tfvars -var-file=../backend.tfvars
~~~

### 배포 시 이슈
2_1_eks에서 admin 이라는 IAM Role 필요. Administrator 정책 필요
2_2_eks_resource 에서 chmod +x 로 sh 파일 권한 부여 필요

3_database 에서 OpenSearch 서비스 링크 역할 없는 경우
~~~bash
aws iam create-service-linked-role \
  --aws-service-name opensearchservice.amazonaws.com
~~~

# 클러스터 접근 예시

~~~bash
aws eks --region ap-northeast-2 update-kubeconfig --name {cluster name}
kubectl config use-context arn:aws:eks:ap-northeast-2:{account id}:cluster/{cluster name}
~~~

## 배포 삭제 

각 폴더에서 역순으로 순차 삭제

~~~bash
terraform destroy -var-file=../terraform.tfvars -var-file=../backend.tfvars -auto-approve
~~~

## ECR 로그인 (일회성)

~~~bash
aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 631704401456.dkr.ecr.ap-northeast-2.amazonaws.com
~~~

## ECR Credential Helper

The ECR credential helper makes it easier to use ECR by seamless passing your AWS credentials to the service. When you use the credential helper there is no need to use ```docker login``` or ```docker logout```.

> Note: If you're planning to use the credential helper with an assumed role, you'll need to set the environment variable AWS_SDK_LOAD_CONFIG=true. The IAM principle you're using has to have permission to ECR too.

Follow below instruction for installation.

- [Installation](https://github.com/awslabs/amazon-ecr-credential-helper)

And add the following to the contents of your ```~/.docker/config.json``` file:

~~~ json
{
    "credHelpers": {
        "<aws_account_id>.dkr.ecr.<region>.amazonaws.com": "ecr-login"
    }
}
~~~

