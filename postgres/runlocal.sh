#!/bin/bash

scriptdir="`dirname \"$0\"`"
data=${scriptdir}/volumes/data
mkdir -p ${data}
data=$(realpath ${data})

docker run \
	-it \
	--rm \
	-p 5432:5432 \
	-v ${data}:/var/lib/postgresql/data \
	brett/postgres \
	/bin/bash
