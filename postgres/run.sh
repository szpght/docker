#!/bin/bash

scriptdir="`dirname \"$0\"`"
data=${scriptdir}/volumes/data
mkdir -p ${data}
data=$(realpath ${data})

docker run \
	-d \
	-p 5432:5432 \
	-v ${data}:/var/lib/postgresql/data \
	-e PGDATA=/var/lib/postgresql/data \
	--name postgres \
	brett/postgres
