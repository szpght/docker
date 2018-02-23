#!/bin/bash
export USER=gitea
exec gosu gitea /usr/local/gitea/gitea web -c /var/lib/gitea/conf/app.ini
