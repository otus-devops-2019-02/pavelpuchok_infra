#!/usr/bin/env bash
set -e

INSTANCE_NAME=reddit-app
MACHINE_TYPE=f1-micro
IMAGE_FAMILY=reddit-full
BOOT_DISK_SIZE=10GB
TAGS=puma-server

gcloud compute instances create ${INSTANCE_NAME} \
    --image-family ${IMAGE_FAMILY} \
    --machine-type ${MACHINE_TYPE} \
    --boot-disk-size ${BOOT_DISK_SIZE} \
    --tags ${TAGS} \
    --metadata startup-script='service redditapp start'

gcloud compute firewall-rules create ${INSTANCE_NAME} \
    --allow tcp:9292 \
    --target-tags ${TAGS}
