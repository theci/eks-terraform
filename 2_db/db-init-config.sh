#!/bin/bash

# ===========================
# 설정 변수
# ===========================
# DB 정보 입력
ROOT_USER="root"             # db root 계정
ROOT_PASS="<root_password>"      # root 비밀번호
HOST="<rds_host>"               # DB 호스트

# Platform에서 DB에 접근할 계정 생성 시 필요한 환경 변수 설정
PLATFORM_USER="airstudio"    # 계정 이름
PLATFORM_PASS="<platform_password>"  

# ===========================
# 1. 플랫폼 접근용 계정 생성
# ===========================
echo "Creating platform account (if not exists)..."

mysql -u $ROOT_USER -p$ROOT_PASS -h $HOST -e "
CREATE USER IF NOT EXISTS '$PLATFORM_USER'@'%' IDENTIFIED BY '$PLATFORM_PASS';
"

if [ $? -ne 0 ]; then
  echo "Error: Failed to create admin or grant privileges"
  exit 1
fi
echo "Platform account created successfully!"

# ===========================
# 2. 데이터베이스 생성 및 계정에 권한 부여
# ===========================
echo "Creating database air_studio and granting all privileges on it to platform user..."

mysql -u $ROOT_USER -p$ROOT_PASS -h $HOST -e "
CREATE DATABASE IF NOT EXISTS \`air_studio\`;
GRANT ALL PRIVILEGES ON \`air_studio\`.* TO '$PLATFORM_USER'@'%';
FLUSH PRIVILEGES;
"

if [ $? -ne 0 ]; then
  echo "Error: Failed to create database or grant privileges"
  exit 1
fi
echo "Database air_studio created and privileges granted to platform user successfully!"

# ===========================
# 3. 덤프 파일 적용
# ===========================
echo "Importing dump file initdata_v2.0.5.sql into air..."
mysql -u $ROOT_USER -p$ROOT_PASS -h $HOST air_studio < "initdata_v2.0.5.sql"

if [ $? -ne 0 ]; then
  echo "Error: Failed to import dump file"
  exit 1
fi
echo "Dump file imported successfully!"
