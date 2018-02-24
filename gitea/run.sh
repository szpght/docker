#!/bin/bash
set -e

#----------------------------------------------------------------------
# Configuration
# Modify the following variables to adjust your gitea setup.

# HTTP_PORT
#    The port on which the gitea web server will listen
HTTP_PORT=3001

# SSH_PORT
#    The port on which the gitea ssh server will listen
SSH_PORT=9093

# DATA_DIR
#    The directory in which all gitea data will be created and stored.
#    Must be an absolute path.
DATA_DIR=/home/gitea

#----------------------------------------------------------------------

dir_vol=${DATA_DIR}/volumes
lib_pg=${dir_vol}/var/lib/postgres/data
lib_gitea=${dir_vol}/var/lib/gitea
log_gitea=${dir_vol}/var/log/gitea
home_gitea=${dir_vol}/home/gitea
mkdir -p ${lib_pg} ${lib_gitea} ${log_gitea} ${home_gitea}

docker run \
	-d \
	-p ${HTTP_PORT}:3000 \
	-p ${SSH_PORT}:22 \
	-v ${lib_pg}:/var/lib/postgresql/data \
	-v ${lib_gitea}:/var/lib/gitea \
	-v ${log_gitea}:/var/log/gitea \
	-v ${home_gitea}:/home/gitea \
	--name gitea \
	--init \
	gitea \
	start
