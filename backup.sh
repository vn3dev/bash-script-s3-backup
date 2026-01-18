#!/bin/bash

BUCKET_NAME="cloud-lab-bash-s3-vn3dev-4002-8922"
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="backup_$TIMESTAMP.tar.gz"
SOURCE_DIR="./data"

echo "Starting backup process..."
echo "Creating compressed file: $BACKUP_FILE"

tar -czf $BACKUP_FILE $SOURCE_DIR

echo "Uploading $BACKUP_FILE to S3 bucket: $BUCKET_NAME"

aws s3 cp $BACKUP_FILE s3://$BUCKET_NAME/ --profile backup-bot

echo "Backup process finished successfully!"