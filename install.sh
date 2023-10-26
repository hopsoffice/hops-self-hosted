#!/usr/bin/env bash

read -p 'Username (default: hops): ' username
read -sp 'Password (default: secret): ' password
read -p 'Domain (default: localhost): ' domain
read -p 'DB Name (default: hops): ' dbname

cat <<EOF > .env
DEPLOY_DOMAIN=${domain:-localhost}
DB_USERNAME=${username:-hops}
DB_PASSWORD=${password:-secret}
DB_NAME=${dbname:-hops}
EOF
