#!/bin/bash

scriptdir="`dirname \"$0\"`"

conf=$(realpath ${scriptdir}/volumes/conf)
html=$(realpath ${scriptdir}/volumes/html)

chmod a+rx ${html}
chmod -R a+r ${html}

docker run -d \
	-p 8080:80/tcp \
	-p 8081:443 \
	-v ${html}:/usr/share/nginx/html:ro \
	-v ${conf}:/etc/nginx:ro \
	--name nginx brett/nginx
