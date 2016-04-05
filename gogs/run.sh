#!/bin/bash
set -e

#----------------------------------------------------------------------
# Configuration
# Modify the following variables to adjust your gogs setup.

# HTTP_PORT
#    The port on which the gogs web server will listen
HTTP_PORT=3000

# SSH_PORT
#    The port on which the gogs ssh server will listen
SSH_PORT=9092

# DATA_DIR
#    The directory in which all gogs data will be created and stored.
#    Must be an absolute path.
DATA_DIR=/volume1/gogs

#----------------------------------------------------------------------

dir_vol=${DATA_DIR}/volumes
lib_pg=${dir_vol}/var/lib/postgres/data
lib_gogs=${dir_vol}/var/lib/gogs
log_gogs=${dir_vol}/var/log/gogs
home_gogs=${dir_vol}/home/gogs
mkdir -p ${lib_pg} ${lib_gogs} ${log_gogs} ${home_gogs}

docker run \
	-d \
	-p ${HTTP_PORT}:3000 \
	-p ${SSH_PORT}:22 \
	-v ${lib_pg}:/var/lib/postgresql/data \
	-v ${lib_gogs}:/var/lib/gogs \
	-v ${log_gogs}:/var/log/gogs \
	-v ${home_gogs}:/home/gogs \
	--name gogs \
	brett/gogs \
	start
