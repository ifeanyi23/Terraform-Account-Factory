#!/usr/bin/env bash
CT_MANAGEMENT_ACCOUNT=$(aws sts get-caller-identity --output text --query Account)
ENVIRONMENT=dev
REGION=ap-southeast-2

if [[ -n "${CT_MANAGEMENT_ACCOUNT:-ACCOUNT_ID}" ]]; then
    aws s3api create-bucket \
        --bucket "${ENVIRONMENT}-${CT_MANAGEMENT_ACCOUNT}-aftbootstrap-tfstate" \
        --create-bucket-configuration LocationConstraint="${REGION}" \
        --region "${REGION}" \
        2> /dev/null
        
    aws s3api put-bucket-versioning \
        --bucket "${ENVIRONMENT}-${CT_MANAGEMENT_ACCOUNT}-aftbootstrap-tfstate" \
        --versioning-configuration Status=Enabled \
        --region "${REGION}" \
        2> /dev/null

    aws dynamodb create-table \
        --table-name ddb-aftbootstrap-state \
        --attribute-definitions AttributeName=LockID,AttributeType=S \
        --key-schema AttributeName=LockID,KeyType=HASH \
        --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
        2> /dev/null
else
    echo "No account ID provided"
fi