terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "bucket_name" {
  default = "cloud-lab-bash-s3-vn3dev-4002-8922"
}

resource "aws_s3_bucket" "backup_bucket" {
  bucket = var.bucket_name
}

resource "aws_iam_user" "backup_user" {
  name = "s3-backup-bot"
}

resource "aws_iam_access_key" "backup_user_key" {
  user = aws_iam_user.backup_user.name
}

resource "aws_iam_user_policy" "backup_policy" {
  name = "S3BackupPolicy"
  user = aws_iam_user.backup_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:PutObject", "s3:ListBucket"]
        Effect   = "Allow"
        Resource = [
          "${aws_s3_bucket.backup_bucket.arn}",
          "${aws_s3_bucket.backup_bucket.arn}/*"
        ]
      }
    ]
  })
}

output "access_key_id" {
  value = aws_iam_access_key.backup_user_key.id
}

output "secret_access_key" {
  value     = aws_iam_access_key.backup_user_key.secret
  sensitive = true
}