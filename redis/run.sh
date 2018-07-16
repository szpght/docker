#!/bin/bash

mkdir -p volumes/data
data=$(realpath volumes/data)
docker run \
	-d \
	-p 6379:6379 \
	--init \
	--restart always \
	-v ${data}:/data \
	--init \
	--name redis \
	redis:5.0-rc \
	redis-server --appendonly yes
