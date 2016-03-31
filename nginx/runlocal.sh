#!/bin/bash

scriptdir="`dirname \"$0\"`"

conf=$(realpath ${scriptdir}/volumes/conf)
html=$(realpath ${scriptdir}/volumes/html)

chmod a+rx ${html}
chmod -R a+r ${html}

docker run --rm -it \
	-p 8080:80 \
	-p 8081:443 \
	-v ${conf}:/etc/nginx \
	-v ${html}:/usr/share/nginx/html \
	brett/nginx /bin/bash
