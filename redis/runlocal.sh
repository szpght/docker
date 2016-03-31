#!/bin/bash

data=$(realpath volumes/data)
docker run \
	-it \
	--rm \
	-p 6379:6379 \
	-v ${data}:/data \
	brett/redis \
	/bin/bash
