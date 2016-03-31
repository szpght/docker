#!/bin/bash

data=$(realpath volumes/data)
docker run \
	-d \
	-p 6379:6379 \
	-v ${data}:/data \
	--name redis \
	brett/redis \
	redis-server --appendonly yes
