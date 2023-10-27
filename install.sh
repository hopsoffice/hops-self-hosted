#!/usr/bin/env bash

read -p 'Username (default: hops): ' username
read -sp 'Password (default: secret): ' password
read -p 'Domain (default: localhost): ' domain
read -p 'DB Name (default: hops): ' dbname

cat <<EOF > .env
HOPS_DEPLOY_DOMAIN=${domain:-localhost}
HOPS_DB_USERNAME=${username:-hops}
HOPS_DB_PASSWORD=${password:-secret}
HOPS_DB_NAME=${dbname:-hops}
HOPS_DB_DATA="./pgdata"
EOF
