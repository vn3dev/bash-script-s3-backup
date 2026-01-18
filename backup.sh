#!/bin/bash

export AWS_PROFILE="backup-bot"
BUCKET_NAME="cloud-lab-bash-s3-vn3dev-4002-8922"
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="backup_$TIMESTAMP.tar.gz"
SOURCE_DIR="./data"

echo "Compressing files..."
tar -czf $BACKUP_FILE $SOURCE_DIR

if [ $? -eq 0 ]; then
    echo "Compression successful."
else
    echo "Compression failed. Exiting script."
    exit 1
fi

echo "Uploading to Amazon S3..."
aws s3 cp $BACKUP_FILE s3://$BUCKET_NAME/

if [ $? -eq 0 ]; then
    echo "Upload successful."
    
    echo "Cleaning up local temporary files..."
    rm $BACKUP_FILE
    echo "Cleanup complete. Process finished."
else
    echo "Upload failed."
    exit 1
fi