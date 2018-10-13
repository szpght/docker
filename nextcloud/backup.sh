#!/bin/bash
dir=`date +"%Y-%m-%d"`
src=/var/lib/docker/volumes/nextcloud_nextcloud/_data
folder=/home/admin/nextcloud/backups/${dir}

echo Copying files from nextcloud volume...
mkdir -p ${folder}
sudo rsync -Aax ${src}/config/ ${folder}/config
sudo rsync -Aax ${src}/data/ ${folder}/data
sudo rsync -Aax ${src}/themes/ ${folder}/themes

echo Creating archive file...
(cd ${folder}; sudo tar cpf ${folder}.tar *)
sudo chown admin:admin ${folder}.tar
sudo rm -rf ${folder}

echo Done.
