#!/bin/sh

# Open the firewall on port 443 before running this.

docker exec nextcloud_letsencrypt-companion_1 /app/force_renew
