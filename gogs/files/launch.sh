#!/bin/bash
export USER=gogs
exec gosu gogs /usr/local/gogs/gogs web -c /var/lib/gogs/conf/app.ini
