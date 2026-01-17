#!/bin/bash

tar -czf backup.tar.gz ./data

aws s3 cp backup.tar.gz s3://cloud-lab-bash-s3-vn3dev-4002-8922/ --profile backup-bot