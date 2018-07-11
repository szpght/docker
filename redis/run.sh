#!/bin/bash

mkdir -p volumes/data
data=$(realpath volumes/data)
docker run \
	-d \
	-p 6379:6379 \
	--init \
	--restart always \
	-v ${data}:/data \
	--name redis \
	brett/redis \
	redis-server --appendonly yes
