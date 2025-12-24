import subprocess
import os
import shutil

def mzc_ecr_login_and_pull(region: str, mzc_registry: str, application: str, image_tag: str = "latest"):
    try:
        # 1. AWS ECR 로그인 비밀번호 가져오기
        print(f"Getting ECR login password for region {region}...")
        result = subprocess.run(
            ["aws", "ecr", "get-login-password", "--region", region],
            check=True,
            capture_output=True,
            text=True
        )
        password = result.stdout.strip()

        # 2. AWS ECR 로그인
        print(f"Logging in to MZC ECR ({mzc_registry}) with docker...")
        login_result = subprocess.run(
            ["docker", "login", "--username", "AWS", "--password-stdin", mzc_registry],
            input=password,
            text=True,
            check=True
        )

        # 3. 이미지 풀
        app_image_full_name = f"{mzc_registry}/{application}:{image_tag}"
        print(f"Pulling image: {app_image_full_name} ...")
        pull_result = subprocess.run(
            ["docker", "pull", app_image_full_name],
            check=True
        )

        print("Image pulled successfully.")

    except subprocess.CalledProcessError as e:
        print("Error occurred during subprocess execution (Pull Phase):")
        print(e.stderr if e.stderr else str(e))

def cleanup_aws_credentials_and_docker_logout(registry_url: str):
    """
    이미지 Push 단계로 넘어가기 전, 기존 IAM User 자격 증명을 제거하여
    EC2 Instance Profile 권한이 적용되도록 환경을 초기화하는 함수
    """
    try:
        # 1. Docker logout
        print(f"Logging out from docker registry: {registry_url}...")
        # check=False로 설정하여 로그인이 안 되어 있어도 스크립트가 중단되지 않게 함
        subprocess.run(["docker", "logout", registry_url], check=False)

        # 2. ~/.aws 디렉터리 삭제 (AWS Configure 정보 제거)
        home_dir = os.path.expanduser("~")
        aws_dir = os.path.join(home_dir, ".aws")
        
        print(f"Removing AWS credentials directory: {aws_dir} ...")
        if os.path.exists(aws_dir):
            shutil.rmtree(aws_dir)
            print("AWS credentials removed successfully. Switching to Instance Profile context.")
        else:
            print("AWS credentials directory not found. Skipping removal.")

    except Exception as e:
        print("Error occurred during cleanup execution:")
        print(str(e))

def customer_ecr_login_and_push(region: str, mzc_registry: str, customer_registry: str, application: str, image_tag: str = "latest"):
    try:
        pull_image_full_name = f"{mzc_registry}/{application}:{image_tag}"
        push_image_full_name = f"{customer_registry}/{application}:{image_tag}"
        
        # 1. TAG 변경
        print(f"Update TAG: {pull_image_full_name} -> {push_image_full_name}")
        result = subprocess.run(
            ["docker", "tag", pull_image_full_name, push_image_full_name],
            check=True,
        )

        # 2. Docker 로그인 (이 시점에서는 EC2 Instance Profile 권한을 사용함)
        print(f"Getting Customer ECR login password for region {region} (using Instance Profile)...")
        result = subprocess.run(
            ["aws", "ecr", "get-login-password", "--region", region],
            check=True,
            capture_output=True,
            text=True
        )
        password = result.stdout.strip()

        print(f"Logging in to Customer ECR ({customer_registry}) with docker...")
        login_result = subprocess.run(
            ["docker", "login", "--username", "AWS", "--password-stdin", customer_registry],
            input=password,
            text=True,
            check=True
        )

        # 3. 이미지 푸시
        print(f"Pushing image: {push_image_full_name} ...")
        pull_result = subprocess.run(
            ["docker", "push", push_image_full_name],
            check=True
        )

        print("Image pushed successfully.")

    except subprocess.CalledProcessError as e:
        print("Error occurred during subprocess execution (Push Phase):")
        print(e.stderr if e.stderr else str(e))


# 환경 변수 및 실행
if __name__ == "__main__":
    MZC_REGISTRY_REGION = "ap-northeast-2"
    MZC_REGISTRY = "722237863813.dkr.ecr.ap-northeast-2.amazonaws.com"
    
    CUSTOMER_REGISTRY_REGION = "ap-southeast-1"
    CUSTOMER_REGISTRY = "631704401456.dkr.ecr.ap-southeast-1.amazonaws.com"

    TARGET_APPS_AND_TAGS_LIST = [
        {
            "app": "air-studio-api",
            "tag": "1.8-cpu.20251121023116"  # 필요한 태그로 수정하세요
        },
        {
            "app": "air-api-gateway",
            "tag": "1.1.20251111104459"  # 필요한 태그로 수정하세요
        },
        {
            "app": "air-studio-app",
            "tag": "v2.1.0"  # 필요한 태그로 수정하세요
        },
        # 필요 시 더 추가
    ]

    for target in TARGET_APPS_AND_TAGS_LIST:
        mzc_ecr_login_and_pull(MZC_REGISTRY_REGION, MZC_REGISTRY, target["app"], target["tag"])

    cleanup_aws_credentials_and_docker_logout(MZC_REGISTRY)

    for target in TARGET_APPS_AND_TAGS_LIST:
        customer_ecr_login_and_push(CUSTOMER_REGISTRY_REGION, MZC_REGISTRY, CUSTOMER_REGISTRY, target["app"], target["tag"])
    
    print("\n>>> All Images pulled and pushed successfully.")
