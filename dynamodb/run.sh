#!/bin/sh
set -e

docker run \
    -d \
    --init \
    --name dynamodb \
    --network brett-net \
    -p 8000:8000 \
    brett/dynamodb
