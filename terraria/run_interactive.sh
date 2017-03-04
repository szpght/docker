#!/bin/bash
set -e

#----------------------------------------------------------------------
# Configuration
#     Modify the following variables to adjust your terraria setup.

# PORT
#    The port you want the terraria server to listen on
PORT=7777

# TERRARIA_DIR
#    The directory containing terraria *.wld files
TERRARIA_DIR=/home/brett/docker/terraria/world

# WORLD_FILE
#    The .wld file within the world directory to run on the server
WORLD_FILE=home.wld

#----------------------------------------------------------------------

docker run \
	--rm \
	-it \
	-p ${PORT}:7777 \
	-v ${TERRARIA_DIR}:/world \
	--name="terraria_tmp" \
	brett/terraria:latest \
	-world /world/${WORLD_FILE}
