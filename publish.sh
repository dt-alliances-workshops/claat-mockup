#!/bin/bash

TARGET=$1

# for CLOUD_FRONT_DISTRIBUTION_ID see
# https://console.aws.amazon.com/cloudfront/v3/home?#/distributions

case "$TARGET" in
    "prod") 
        TARGET_URL=s3://alliances-learn-content
        CLOUD_FRONT_DISTRIBUTION_ID=E2LSLQ6AAL5WKJ
        ;;
    "staging") 
        TARGET_URL=s3://alliances-learn-content-stg
        CLOUD_FRONT_DISTRIBUTION_ID=E137VF5PUN9RRG
        ;;
    *)
        echo ""
        echo "-----------------------------------------------------------------------------------"
        echo "ERROR: Missing or invalid TARGET argument"
        echo "Valid values are: prod, staging"
        echo ""
        exit 1
        ;;
esac

if [ ! -d "./dist" ] || [ ! "$(ls -A ./dist)" ];
then
    echo ""
    echo "-----------------------------------------------------------------------------------"
    echo "ERROR: dist directory does not exist or is empty."
    echo "Please compile site content before publishing"
    echo ""
    exit 1
fi

echo "==================================================================="
echo "About to publish site content to: $TARGET"
echo "$TARGET_URL"
echo "==================================================================="
read -p "Proceed? (y/n) : " REPLY;

if [[ $REPLY =~ ^[Yy]$ ]]; then

    # echo "---------------------------------------"
    # echo "Step 1: Compile Site"
    # echo "---------------------------------------"
    # gulp dist

    echo ""
    echo "---------------------------------------"
    echo "Step 1: Sync to S3"
    echo "---------------------------------------"


    echo ""
    echo "---------------------------------------"
    echo "Step 1: Sync to S3"
    echo "---------------------------------------"
    aws s3 sync dist/ $TARGET_URL 

    echo ""
    echo "---------------------------------------"
    echo "Step 2: Create CloudFront invalidation"
    echo "---------------------------------------"
    aws cloudfront create-invalidation \
        --distribution-id $CLOUD_FRONT_DISTRIBUTION_ID \
        --paths '/*'

    echo ""
    echo "---------------------------------------"
    echo "Done"
    echo "---------------------------------------"
    echo ""

fi