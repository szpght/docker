#!/bin/bash

mkdir -p volumes/data
data=$(realpath volumes/data)
docker run \
	-d \
	-p 6379:6379 \
	--name redis \
	--init \
	--restart always \
	-v ${data}:/data \
	redis:4.0 \
	redis-server --appendonly yes
