#!/usr/bin/env bash

echo "Testing AWS Secrets Manager Connection..."
echo "========================================="
echo ""

# Check AWS credentials file
echo "1. Checking AWS credentials file..."
if [ -f ~/.aws/credentials ]; then
    echo "   ✓ Credentials file exists"
    if grep -q "aws_access_key_id" ~/.aws/credentials; then
        echo "   ✓ Access key configured"
    else
        echo "   ✗ Access key NOT found"
        exit 1
    fi
    if grep -q "aws_secret_access_key" ~/.aws/credentials; then
        echo "   ✓ Secret key configured"
    else
        echo "   ✗ Secret key NOT found"
        exit 1
    fi
else
    echo "   ✗ Credentials file NOT found at ~/.aws/credentials"
    exit 1
fi

echo ""
echo "2. Checking AWS config file..."
if [ -f ~/.aws/config ]; then
    echo "   ✓ Config file exists"
    REGION=$(grep "region" ~/.aws/config | head -1 | awk -F'=' '{print $2}' | xargs)
    echo "   ✓ Region: $REGION"
else
    echo "   ✗ Config file NOT found at ~/.aws/config"
    exit 1
fi

echo ""
echo "3. Testing connection to AWS Secrets Manager..."

# Check if aws-cli is installed
if command -v aws &> /dev/null; then
    echo "   Using AWS CLI to test connection..."
    aws secretsmanager get-secret-value --secret-id plutus --region us-east-2 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "   ✓ Successfully connected to AWS Secrets Manager"
        echo "   ✓ Secret 'plutus' exists and is accessible"
        echo ""
        echo "4. Secret content preview:"
        aws secretsmanager get-secret-value --secret-id plutus --region us-east-2 --query SecretString --output text | jq .
    else
        echo "   ✗ Failed to connect to AWS Secrets Manager"
        echo ""
        echo "Error details:"
        aws secretsmanager get-secret-value --secret-id plutus --region us-east-2 2>&1
        exit 1
    fi
else
    echo "   ⚠ AWS CLI not installed - skipping connection test"
    echo "   Install with: pip install awscli"
fi

echo ""
echo "========================================="
echo "AWS Configuration appears to be correct!"

