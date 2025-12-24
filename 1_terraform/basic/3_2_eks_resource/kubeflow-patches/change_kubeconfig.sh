#!/bin/bash
set -x

CLUSTER_NAME="$1"
ACCOUNT_ID="$2"
REGION="$3"
PROFILE="$4"

aws eks --region $REGION update-kubeconfig --name "$CLUSTER_NAME" --profile "$PROFILE" ##프로필 추가 ##수정수정 
kubectl config use-context arn:aws:eks:$REGION:"$ACCOUNT_ID":cluster/"$CLUSTER_NAME" #수정

# MATILDA_DIR="$(pwd)/03-platform"
# MANIFESTS_DIR="${MATILDA_DIR}/matilda-manifests"
# echo ${MANIFESTS_DIR}

# rm -rf ${MANIFESTS_DIR}
# # Copy templates to manifests directory
# cp -r "${MATILDA_DIR}/matilda-templates" "${MANIFESTS_DIR}"

# # Debug: List files in the manifests directory
# echo "Files in ${MANIFESTS_DIR}"
# find "${MANIFESTS_DIR}" -type f

# # Replace placeholders in files

# find "${MANIFESTS_DIR}" -type f -exec sed -i '' -e "s/{nexus_domain}/$1/g" {} \;
# find "${MANIFESTS_DIR}" -type f -exec sed -i '' -e "s/{nexus_web_domain}/$2/g" {} \;
# find "${MANIFESTS_DIR}" -type f -exec sed -i '' -e "s/{platform_domain}/$3/g" {} \;
# find "${MANIFESTS_DIR}" -type f -exec sed -i '' -e "s/{litellm_host_name}/litellm.$3/g" {} \;
# find "${MANIFESTS_DIR}" -type f -exec sed -i '' -e "s/{lago_host_name}/lago.$3/g" {} \;
# find "${MANIFESTS_DIR}" -type f -exec sed -i '' -e "s/{lago_api_host_name}/lago-api.$3/g" {} \;
# find "${MANIFESTS_DIR}" -type f -exec sed -i '' -e "s/{platform_image_respository}/$4/g" {} \;
# find "${MANIFESTS_DIR}" -type f -exec sed -i '' -e "s/{nexus_docker_config}/$5/g" {} \;
# find "${MANIFESTS_DIR}" -type f -exec sed -i '' -e "s/{mlops_backend_tag}/$6/g" {} \;
# find "${MANIFESTS_DIR}" -type f -exec sed -i '' -e "s/{asset_backend_tag}/$7/g" {} \;
# find "${MANIFESTS_DIR}" -type f -exec sed -i '' -e "s/{portal_frontend_tag}/$8/g" {} \;
# find "${MANIFESTS_DIR}" -type f -exec sed -i '' -e "s/{admin_frontend_tag}/$9/g" {} \;
# find "${MANIFESTS_DIR}" -type f -exec sed -i '' -e "s/{OBJECT_STORAGE_ENDPOINT}/${10}/g" {} \;
# find "${MANIFESTS_DIR}" -type f -exec sed -i '' -e "s/{OBJECT_STORAGE_ACCESS_KEY_ID}/${11}/g" {} \;
# find "${MANIFESTS_DIR}" -type f -exec sed -i '' -e "s/{OBJECT_STORAGE_SECRET_ACCESS_KEY_ID}/${12}/g" {} \;
# find "${MANIFESTS_DIR}" -type f -exec sed -i '' -e "s/{GITEA_API_KEY}/${13}/g" {} \;

# find "${MANIFESTS_DIR}" -type f -exec sed -i '' -e "s/{platform-dex-tag}/${14}/g" {} \;
# find "${MANIFESTS_DIR}" -type f -exec sed -i '' -e "s/{platform-background-tag}/${15}/g" {} \;
# find "${MANIFESTS_DIR}" -type f -exec sed -i '' -e "s/{project-exporter-tag}/${16}/g" {} \;
# find "${MANIFESTS_DIR}" -type f -exec sed -i '' -e "s/{user-exporter-tag}/${17}/g" {} \;

