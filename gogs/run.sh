#!/bin/bash

scriptdir="`dirname \"$0\"`"
vardir=${scriptdir}/var
lib_pg=${vardir}/lib/postgres/data
lib_gogs=${vardir}/lib/gogs
log_gogs=${vardir}/log/gogs

mkdir -p ${lib_pg} ${lib_gogs} ${log_gogs}
lib_pg=$(realpath ${lib_pg})
lib_gogs=$(realpath ${lib_gogs})
log_gogs=$(realpath ${log_gogs})

docker run \
	-d \
	-p 3000:3000 \
	-p 9092:22 \
	-v ${lib_pg}:/var/lib/postgresql/data \
	-v ${lib_gogs}:/var/lib/gogs \
	-v ${log_gogs}:/var/log/gogs \
	--name gogs \
	brett/gogs \
	start
